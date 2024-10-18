import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';
import 'package:capstone_user_2/Login/loginClass.dart';

class LoginPage extends StatelessWidget {
  final LoginClass loginClass = LoginClass();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF696CFF), // 배경 색깔 설정
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 140.0), // 이미지 위에 여백 추가
                child: SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      loginClass.login();
                    },
                    child: Image.asset(
                      'assets/image/kakao_login_large_wide.png', // 이미지 경로가 pubspec.yaml에 추가되었는지 확인
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 250, // 텍스트를 더 아래로 이동
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No.1 대학 동아리 플랫폼',
                    style: TextStyle(
                      fontFamily: "laundrygothic", // 여기에 등록한 폰트 이름 사용
                      color: Colors.white, // 흰색 글씨
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 3), // 텍스트 간의 간격 조정
                  Text(
                    '여기모여',
                    style: TextStyle(
                      fontFamily: "laundrygothic", // 여기에 등록한 폰트 이름 사용
                      color: Colors.white, // 흰색 글씨
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
