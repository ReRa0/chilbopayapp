import 'package:flutter/material.dart';
import 'signup_page.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              children: [
                TextSpan(
                  text: '칠보페이 이용약관\n\n',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '최종 개정일: 2024-12-18\n\n',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '1. 약관의 목적\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '이 약관은 칠보페이(이하 "본 앱")의 이용과 관련하여 사용자와 앱 제공자 간의 권리, 의무, 책임 사항 및 기타 필요한 사항을 규정합니다. 본 앱은 수원칠보고등학교 행사에서 포인트를 적립하고 사용하는 방식으로 상품을 획득할 수 있도록 돕기 위해 제작되었습니다.\n\n',
                ),
                TextSpan(
                  text: '2. 서비스 제공 및 목적\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 앱은 수원칠보고등학교 행사에 참여하여 포인트를 적립하고 이를 상품 교환에 사용하는 서비스입니다.\n\n제공되는 포인트는 실제 화폐가 아니며, 학교 내 특정 활동에서만 사용 가능합니다.\n\n',
                ),
                TextSpan(
                  text: '3. 사용자 계정 및 관리\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 앱은 수원칠보고등학교 학생을 대상으로 제공됩니다.\n\n계정 정보는 타인과 공유할 수 없으며, 이를 위반할 경우 계정이 제한될 수 있습니다.\n\n',
                ),
                TextSpan(
                  text: '4. 포인트 적립 및 사용\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '포인트는 수원칠보고등학교에서 승인한 행사 참여를 통해 적립됩니다.\n\n적립된 포인트는 앱 내에서 지정된 상품으로만 교환할 수 있으며, 환불이나 현금화는 불가능합니다.\n\n부정한 방법으로 포인트를 적립하거나 사용하는 경우 해당 포인트는 몰수됩니다.\n\n',
                ),
                TextSpan(
                  text: '5. 개인정보 보호\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 앱은 사용자 정보를 안전하게 보호하며, 수집된 개인정보는 다음의 목적으로만 사용됩니다:\n\n포인트 적립 및 사용 관리\n\n학교 행사 참여 데이터 분석\n\n개인정보는 관련 법률(예: 개인정보 보호법)에 따라 보호되며, 사용자는 언제든지 자신의 개인정보를 열람, 수정, 삭제 요청할 수 있습니다.\n\n',
                ),
                TextSpan(
                  text: '6. 책임의 제한\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 앱은 서비스 운영과 관련하여 다음 사항에 대해 책임을 지지 않습니다:\n\n기술적 오류로 인한 포인트 손실\n\n사용자 부주의로 발생한 계정 유출\n\n수원칠보고등학교 외부에서의 포인트 사용 시도\n\n',
                ),
                TextSpan(
                  text: '7. 서비스 변경 및 중단\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 앱은 학교 정책이나 기타 불가피한 사유로 서비스 내용을 변경하거나 중단할 수 있습니다.\n\n변경 또는 중단 시 사용자에게 사전에 고지합니다.\n\n',
                ),
                TextSpan(
                  text: '8. 분쟁 해결 및 준거법\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                  '본 약관과 관련하여 분쟁이 발생할 경우, 수원칠보고등학교의 내부 규정을 따르며, 필요 시 관련 법률에 따라 해결합니다.\n\n',
                ),
                TextSpan(
                  text: '9. 문의 사항\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '본 앱과 관련된 문의 사항은 수원칠보고등학교 학생회를 통해 문의하십시오.\n',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}