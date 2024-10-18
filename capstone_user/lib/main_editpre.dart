import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
      nativeAppKey: '25bc2ff968011817ccb3729b3d5c9b28'); // 실제 카카오 앱 키를 넣어야 합니다.
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
      } on PlatformException catch (error) {
        if (error.code == 'CANCELED') {
          // 사용자가 취소한 경우 처리
          print('사용자가 로그인을 취소했습니다.');
        } else {
          // 다른 오류 처리
          print('로그인 실패: ${error.message}');
        }
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
                      login();
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
