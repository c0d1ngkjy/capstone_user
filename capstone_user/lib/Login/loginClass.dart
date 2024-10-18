import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';

class LoginClass {
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
}
