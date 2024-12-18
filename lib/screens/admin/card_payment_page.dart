import 'package:flutter/material.dart';
import '../../services/admin_api.dart';
import 'nfc_payment_page.dart';
import 'qr_payment_page.dart';
import 'product_settings_page.dart';

class CardPaymentPage extends StatefulWidget {
  @override
  _CardPaymentPageState createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  List products = [];
  Map<int, int> productCounts = {};
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final data = await AdminApi.fetchProducts();
      setState(() {
        products = data;
        productCounts = {for (var product in data) product['id']: 0};
        _calculateTotalAmount();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('상품 불러오기 실패')),
      );
    }
  }

  void _calculateTotalAmount() {
    int total = 0;
    for (var product in products) {
      final productId = product['id'];
      final int productPrice = (product['price'] as num).toInt();
      final int count = (productCounts[productId] ?? 0).toInt();
      total += productPrice * count;
    }
    setState(() {
      totalAmount = total;
    });
  }

  void _showPaymentMethodDialog() {
    if (totalAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('최소한 한 개의 상품을 선택해주세요.')),
      );
      return;
    }

    final selectedProducts = productCounts.keys
        .where((id) => (productCounts[id] ?? 0) > 0)
        .map((id) => {'id': id, 'count': productCounts[id] ?? 0})
        .toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("결제 방법을 선택해주세요."),
          content: Text("결제 방법을 선택해주세요."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NfcPaymentPage(selectedProducts: selectedProducts),
                  ),
                );
              },
              child: Text("카드 결제"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QrPaymentPage(selectedProducts: selectedProducts),
                  ),
                );
              },
              child: Text("QR 결제"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카드 결제'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductSettingsPage(),
                ),
              );
              _fetchProducts(); // 설정 페이지에서 돌아오면 상품 목록을 새로 고침
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final productId = product['id'];
                final productPrice = product['price'] ?? 0;
                final productCount = productCounts[productId] ?? 0;

                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('Price: $productPrice'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (productCount > 0) {
                              productCounts[productId] = productCount - 1;
                              _calculateTotalAmount();
                            }
                          });
                        },
                      ),
                      Text('$productCount'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            productCounts[productId] = productCount + 1;
                            _calculateTotalAmount();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '합계: $totalAmount',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _showPaymentMethodDialog,
                  child: Text('결제'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
