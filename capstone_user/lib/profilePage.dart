import 'package:capstone_user/signinPage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF696CFF),
        ),
        child: const Text('Open route'),
        onPressed: () {
          // Navigate to second route when tapped.
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Signinpage()));
        },
      ),
    );
  }
}
