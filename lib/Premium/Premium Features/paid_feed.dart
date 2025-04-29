import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'tracker_page.dart';
import 'my_diet_page.dart';
import 'welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaidFeed extends StatefulWidget {
  @override
  _PaidFeedState createState() => _PaidFeedState();
}

class _PaidFeedState extends State<PaidFeed> {
  int _selectedIndex = 0;
  List<Widget> tabItems = [
    TrackerPage(),
    SwipeSlider(),
  ];

  bool _showWelcomePage = true; // Initially, show the WelcomePage

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser(); // Check if the user is a first-time user
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _showWelcomePage = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _showWelcomePage
          ? WelcomePage(
        onDismiss: _dismissWelcome,
      )
          : buildPaidFeed(),
    );
  }

  Widget buildPaidFeed() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paid Feed',
          style: TextStyle(color: Color(0xFFD4AF37), fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Color(0xFFF7F7F9),
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.calendar_month_rounded, size: 35, color: Color(0xFFD4AF37)),
            title: Text('Tracker', style: TextStyle(color: Color(0xFFD4AF37))),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.local_fire_department, size: 35, color: Color(0xFFD4AF37)),
            title: Text('My Diet', style: TextStyle(color: Color(0xFFD4AF37))),
          ),
        ],
      ),
    );
  }

  void _dismissWelcome(TimeOfDay? selectedTime) async {
    // Save in shared preferences that the user has already set their workout time
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
    setState(() {
      _showWelcomePage = false;
    });
  }
}
