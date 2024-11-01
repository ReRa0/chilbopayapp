import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static const String baseUrl = 'http://114.204.195.233';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // Fetch user data by userId
  static Future<Map<String, dynamic>> fetchUserData(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/$userId'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception('Failed to load user data: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  // Update user with optional parameters for username, password, and money
  static Future<void> updateUser(int userId, {String? username, String? password, int? money}) async {
    Map<String, dynamic> body = {};

    if (username != null) body['username'] = username;
    if (password != null) body['password'] = password;
    if (money != null) body['money'] = money;

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/$userId'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception('Failed to update user: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  // Fetch user transactions by userId
  static Future<List<dynamic>> fetchTransactions(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/transactions/$userId'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception('Failed to load transactions: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }

  // NFC 카드 등록 메서드
  static Future<Map<String, dynamic>> registerNfcCard(int userId, String cardId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register-nfc'),
        headers: headers,
        body: jsonEncode({
          'userId': userId,
          'cardId': cardId,
        }),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'NFC card registered successfully'};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to register NFC card: $e'};
    }
  }

  // NFC 카드 해제 메서드
  static Future<Map<String, dynamic>> unregisterNfcCard(int userId, String cardId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/unregister-nfc'),
        headers: headers,
        body: jsonEncode({
          'userId': userId,
          'cardId': cardId,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'NFC card unregistered successfully'};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to unregister NFC card: $e'};
    }
  }

  // Delete user account
  static Future<void> deleteUser(int userId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/user/$userId'));

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception('Failed to delete account: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error deleting account: $e');
    }
  }

  // QR 토큰 생성 API
  static Future<String> generateQrToken(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/generateQrToken'),
        headers: headers,
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'];
      } else {
        throw Exception('Failed to generate QR token');
      }
    } catch (e) {
      throw Exception('Error generating QR token: $e');
    }
  }

// 사용자 이름으로 수신자 정보 가져오기
  static Future<Map<String, dynamic>?> fetchUserDataByUsername(String username) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/by-username/$username'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching receiver data: $e');
    }
  }

  // 송금 트랜잭션 생성
  static Future<bool> createTransaction(int senderId, int receiverId, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/transaction'),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'senderId': senderId,
          'receiverId': receiverId,
          'amount': amount,
          'userId': senderId,  // checkUserStatus 미들웨어를 위해 userId 추가
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Error creating transaction: $e');
    }
  }


}
