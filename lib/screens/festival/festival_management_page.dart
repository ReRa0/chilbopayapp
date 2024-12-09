import 'package:flutter/material.dart';
import '../../services/festival_api.dart';

class FestivalManagementPage extends StatefulWidget {
  final int festivalId;

  FestivalManagementPage({required this.festivalId});

  @override
  _FestivalManagementPageState createState() => _FestivalManagementPageState();
}

class _FestivalManagementPageState extends State<FestivalManagementPage> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> activities = [];
  bool showProducts = true;
  int? activityCount; // 남은 횟수를 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchActivityCount();
    _fetchProducts();
    _fetchActivities();
  }

  Future<void> _fetchActivityCount() async {
    try {
      final user = await FestivalApi.fetchUserData(widget.festivalId);
      setState(() {
        activityCount = user['activityCount'];
      });
    } catch (e) {
      print('Failed to fetch activity count: $e');
    }
  }

  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await FestivalApi.fetchFestivalProducts(widget.festivalId);
      setState(() {
        products = List<Map<String, dynamic>>.from(fetchedProducts);
      });
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  Future<void> _fetchActivities() async {
    try {
      // fetchFestivalActivities가 이제 Map을 반환합니다.
      // { "activityCount": int, "activities": [ ... ] }
      final data = await FestivalApi.fetchFestivalActivities(widget.festivalId);
      setState(() {
        // 서버 응답에서 activityCount도 여기서 업데이트 할 수 있음
        if (data['activityCount'] != null) {
          activityCount = data['activityCount'];
        }
        activities = List<Map<String, dynamic>>.from(data['activities']);
      });
    } catch (e) {
      print('Failed to fetch activities: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Festival Management'),
      ),
      body: Column(
        children: [
          // 남은 횟수 표시 부분
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              activityCount == null
                  ? 'Loading activity count...'
                  : '남은 활동 횟수: $activityCount 회',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => setState(() => showProducts = true),
                child: Text('Products'),
              ),
              TextButton(
                onPressed: () => setState(() => showProducts = false),
                child: Text('Activities'),
              ),
            ],
          ),
          Expanded(
            child: showProducts ? _buildProductList() : _buildActivityList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return products.isEmpty
        ? Center(child: Text('No products available.'))
        : ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]['name']),
          subtitle: Text('Price: ${products[index]['price']}'),
        );
      },
    );
  }

  Widget _buildActivityList() {
    return activities.isEmpty
        ? Center(child: Text('No activities available.'))
        : ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(activities[index]['name']),
          subtitle: Text('Reward: ${activities[index]['price']}'),
        );
      },
    );
  }
}
