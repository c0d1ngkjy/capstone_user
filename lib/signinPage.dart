import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget{
  const SigninPage({Key?key}) : super(key: key);

  @override
  _SigninpageState createState() => _SigninpageState();
}


class _SigninpageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '이름',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '전화번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '학교',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '전공',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 490,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50, // 크기 조절
              child: TextField(
                decoration: InputDecoration(
                  labelText: '학번',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 560,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF696CFF),
                  surfaceTintColor: const Color(0xFF696CFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // 회원가입 처리
                },
                child: const Text('회원가입'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}