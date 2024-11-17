import 'package:flutter/material.dart';
import 'package:chilbopay/screens/login/login_page.dart';
import 'package:chilbopay/screens/shared/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false; // 이 값을 동적으로 설정 가능 (예: MediaQuery 사용)

    return MaterialApp(
      title: 'ChilboPay',
      theme: appTheme(isDarkMode),
      home: LoginPage(),
    );
  }
}