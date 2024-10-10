import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '회원가입',
      home: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                // 상단 버튼 (예시)
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("뒤로가기"),
                  ),
                ),
                SizedBox(height: 10),

                // 닉네임 입력 필드
                buildTextField('닉네임'),

                // 이름 입력 필드
                buildTextField('이름'),

                // 이메일 입력 필드
                buildTextField(
                  '이메일',
                  keyboardType: TextInputType.emailAddress,
                ),

                // 전화번호 입력 필드
                buildTextField(
                  '전화번호',
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                ),

                // 학교 입력 필드
                buildTextField('학교'),

                // 전공 입력 필드
                buildTextField('전공'),

                // 학번 입력 필드
                buildTextField(
                  '학번',
                  keyboardType: TextInputType.number,
                ),

                // 회원가입 버튼
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF696CFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      // 회원가입 처리 로직 추가
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 공통된 TextField 빌더 메소드
  Widget buildTextField(
    String labelText, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return SizedBox(
      height: 70,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
      ),
    );
  }
}
