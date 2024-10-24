import 'package:capstone_user/clubListPage.dart';
import 'package:capstone_user/communityPage.dart';
import 'package:capstone_user/profilePage.dart';
import 'package:capstone_user/tradeMarketPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '여기모여',
      theme: ThemeData(
        primaryColor: const Color(0xFF696CFF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ClubListPage(),
    CommunityPage(),
    TradeMarketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('여기모여'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF696CFF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '동아리'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: '커뮤니티'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '중고거래'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
    );
  }
}
