import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart';
import 'signinPage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'dart:convert'; // jsonEncode, jsonDecode 사용을 위해 필요
import 'package:http/http.dart' as http; // http 패키지 import

void main() async{
  await dotenv.load(fileName: 'assets/config/.env');
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey:dotenv.env['KAKAO_LOGIN_API']!);
  runApp(const MyApp()); // 전체 앱이 MaterialApp으로 감싸져야 함
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '여기모여',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginPage(), // 앱의 첫 화면으로 loginPage 설정
    );
  }
}

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF696CFF), // 배경 색깔 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0), // 아래쪽 간격 조정
              child: const Text(
                'No.1 대학 동아리 플랫폼',
                style: TextStyle(
                  fontFamily: "laundrygothic",  // 여기에 등록한 폰트 이름 사용
                  color: Colors.white, // 흰색 글씨
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 130.0), // 아래쪽 간격 조정
              child: const Text(
                '여기모여',
                style: TextStyle(
                  fontFamily: "laundrygothic",  // 여기에 등록한 폰트 이름 사용
                  color: Colors.white, // 흰색 글씨
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // 텍스트와 버튼 사이의 간격 (상하 간격 자유 조절 가능)
              child: SizedBox(
                width: 340, // 버튼 너비
                child: InkWell(
                  onTap: () async {
                    await login(context); // context 전달
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

Future<void> login(BuildContext context) async {
  // 카카오톡 로그인 처리 로직
  if (await isKakaoTalkInstalled()) {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      await userInfoSendtoServer(context);
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        await userInfoSendtoServer(context);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      await userInfoSendtoServer(context);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}

Future<void> userInfoSendtoServer(BuildContext context) async {
  try {
    User user = await UserApi.instance.me(); // 사용자 정보 요청

    // 서버 전송 로직
    Map<String, dynamic> data = {
      'kakaoId': user.id.toString(),
      'email': user.kakaoAccount?.email ?? '',
    };

    // 서버 URL 설정 (안드로이드, iOS)
    String url;
    if (Platform.isAndroid) {
      url = 'http://10.0.2.2:3000/auth/kakao-login';
    } else if (Platform.isIOS) {
      url = 'http://localhost:3000/auth/kakao-login';
    } else {
      throw UnsupportedError('이 플랫폼에서는 지원되지 않습니다.');
    }

    // 서버 요청 코드
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = jsonDecode(response.body);

      if (responseData['needsRegister'] == true) {
        print('회원가입이 필요합니다.');
        showRegisterDialog(context); // 회원가입 Dialog 호출
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // HomePage로 이동
        );
      }
    } else {
      print('서버 응답 오류: ${response.statusCode}');
    }
  } catch (error) {
    print('사용자 정보 요청 실패: $error');
  }
}

void showRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('회원가입 필요'),
        content: const Text('회원가입을 하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('아니오'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SigninPage()), // HomePage로 이동
              );
            },
            child: const Text('예'),
          ),
        ],
      );
    },
  );
}

