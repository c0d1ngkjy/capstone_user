import 'dart:convert';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class KakaoOAuthService {
  final String _authorizationEndpoint =
      'https://kauth.kakao.com/oauth/authorize';
  final String _tokenEndpoint = 'https://kauth.kakao.com/oauth/token';
  final String _clientId = '9f7d79718257b5a77723a5f9906bbcec';
  final String _redirectUri = 'kakao9f7d79718257b5a77723a5f9906bbcec://oauth';

  // 로그인 메서드
  Future<void> login(BuildContext context) async {
    try {
      print('카카오 로그인 시작');
      final authCode = await _getAuthorizationCode();
      if (authCode != null) {
        print('인증 코드 획득: $authCode');
        await _requestToken(authCode, context);
      } else {
        throw '인증 코드가 없습니다';
      }
    } catch (e) {
      print('로그인 오류: $e');
    }
  }

  Future<String?> _getAuthorizationCode() async {
    final authorizationUrl = Uri.parse(
        '$_authorizationEndpoint?client_id=$_clientId&redirect_uri=$_redirectUri&response_type=code');

    print('인증 URL 열기: $authorizationUrl');
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    } else {
      throw '$authorizationUrl을 열 수 없습니다';
    }

    // Try to get the initial link
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        final uri = Uri.parse(initialLink);
        final code = uri.queryParameters['code'];
        print('추출된 코드: $code');
        return code;
      }
    } catch (e) {
      print('링크 처리 오류: $e');
    }

    // Set up a listener for deep links (redirect URI)
    final initialLinkStream = uriLinkStream;
    await for (final link in initialLinkStream) {
      if (link != null) {
        final uri = Uri.parse(link as String);
        final code = uri.queryParameters['code'];
        print('스트림에서 추출된 코드: $code');
        if (code != null) return code;
      }
    }
    return null;
  }

  Future<void> _requestToken(String authCode, BuildContext context) async {
    final response = await http.post(
      Uri.parse(_tokenEndpoint),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'client_id': _clientId,
        'redirect_uri': _redirectUri,
        'code': authCode,
      },
    );

    print('Token request status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      print('액세스 토큰: $accessToken');
      _onLoginSuccess(context, accessToken); // 성공 시 추가 작업 수행
    } else {
      throw '액세스 토큰 요청 실패: ${response.body}';
    }
  }

  void _onLoginSuccess(BuildContext context, String accessToken) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('로그인에 성공했습니다'),
        duration: Duration(seconds: 2),
      ),
    );

    print('로그인 성공 액세스 토큰: $accessToken');

    // Future.delayed(Duration(seconds: 2), () {
    //   // 예: 다른 페이지로 이동하거나 추가 작업 수행
    //   // Navigator.of(context).pushReplacementNamed('/home');
    // });
  }
}
