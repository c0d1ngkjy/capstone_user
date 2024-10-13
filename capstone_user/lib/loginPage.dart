import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:capstone_user/kakaoOAuthService.dart';

class LoginPage extends StatelessWidget {
  final KakaoOAuthService _kakaoService = KakaoOAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: InkWell(
          onTap: () async {
            await _kakaoService.login(context);
          },
          child: Image.asset('assets/images/kakao_login_medium_narrow.png'),
        ),
      ),
    );
  }
}
