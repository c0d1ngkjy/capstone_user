import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
      nativeAppKey: ''); // 실제 카카오 앱 키를 넣어야 합니다.
  runApp(loginPage());
}

Future<void> requestUserInfo() async {
  try {
    User user = await UserApi.instance.me(); // 사용자 정보 요청
    print('사용자 정보 요청 성공'
        '\n회원번호: ${user.id}'
        '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
        '\n이메일: ${user.kakaoAccount?.email}'
        '\n핸드폰 번호: ${user.kakaoAccount?.phoneNumber}');
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
  }
}

Future<void> login() async {
  if (await isKakaoTalkInstalled()) {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      await requestUserInfo(); // 사용자 정보 요청
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공 ${token.accessToken}');
        await requestUserInfo(); // 사용자 정보 요청
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      await requestUserInfo(); // 사용자 정보 요청
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                child: InkWell(
                  onTap: () async {
                    login();
                  },
                  child: Image.asset(
                    'assets/image/kakao_login_large_wide.png', // 이미지 경로가 pubspec.yaml에 추가되었는지 확인
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
