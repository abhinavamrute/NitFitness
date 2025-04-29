import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home/Home.dart';
import 'Premium/PremHome.dart';
import 'EnteringPages/extract.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppStartScreen(),
    );
  }
}

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  _AppStartScreenState createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  bool _isFirstTimeUser = true; // Default to true until SharedPreferences is checked
  bool _isPremiumMember = false; // Default to false until SharedPreferences is checked

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser(); // Check user status on widget initialization
  }

  Future<void> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeUser') ?? true; // Default to true if key not found
    bool isPremiumMember = prefs.getBool('isPremiumMember') ?? false; // Default to false if key not found

    setState(() {
      _isFirstTimeUser = isFirstTime;
      _isPremiumMember = isPremiumMember;
    });

    if (isFirstTime) {
      // If it's the first time user, navigate to the Extract page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Extract()),
      );

      // Set isFirstTimeUser to false for subsequent app runs
      prefs.setBool('isFirstTimeUser', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show appropriate screen based on user status
    return _isPremiumMember ? PremHome() : Home();
  }
}
