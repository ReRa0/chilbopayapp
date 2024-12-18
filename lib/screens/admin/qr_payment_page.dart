import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../services/admin_api.dart';
import 'payment_complete_page.dart'; // 결제 완료 페이지 import
import 'payment_failed_page.dart';

class QrPaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;

  QrPaymentPage({required this.selectedProducts});

  @override
  _QrPaymentPageState createState() => _QrPaymentPageState();
}

class _QrPaymentPageState extends State<QrPaymentPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String message = 'QR코드를 카메라에 대주세요.';
  QRViewController? controller;
  bool isProcessing = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      final token = scanData.code;
      if (token == null) {
        setState(() {
          message = 'QR코드가 유효하지 않습니다.';
        });
        controller.resumeCamera();
        return;
      }

      setState(() {
        isProcessing = true;
        message = '결제 진행 중...';
      });

      try {
        for (var product in widget.selectedProducts) {
          final int productId = product['id'];
          final int count = product['count'];

          for (int i = 0; i < count; i++) {
            final result = await AdminApi.processPaymentWithToken(token, productId);
            if (!result['success']) {
              setState(() {
                message = result['message'];
                isProcessing = false; // End loading on failure
              });
              // Navigate to PaymentFailedPage with the error message
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentFailedPage(
                    errorMessage: result['message'] ?? '결제에 실패하였습니다.',
                  ),
                ),
              );
              controller.resumeCamera();
              return; // Exit on payment failure
            }
          }
        }

        // Payment completed successfully
        setState(() {
          message = '결제 완료!';
        });

        // Navigate to PaymentCompletePage on success
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentCompletePage(),
          ),
        );
      } catch (e) {
        // Handle QR payment failure
        setState(() {
          isProcessing = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentFailedPage(
              errorMessage: 'Failed to pay with QR code: $e',
            ),
          ),
        );
      } finally {
        setState(() {
          isProcessing = false; // Stop loading after processing
        });
        controller.resumeCamera();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR코드 결제')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: isProcessing
                  ? CircularProgressIndicator()
                  : Text(
                message,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
