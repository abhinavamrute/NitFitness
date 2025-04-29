import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'PremHomePage.dart';
import '../Home/BMIPage.dart';
import '../Home/ArticlesPage.dart';
import 'PlanValidity.dart';
import 'Premium Features/paid_feed.dart';

class PremHome extends StatefulWidget {
  final int initialPageIndex; // Define initialPageIndex parameter

  PremHome({Key? key, this.initialPageIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(initialPageIndex: initialPageIndex);
}

class _HomeState extends State<PremHome> {
  late int _currentPage;
  late PageController _pageController;

  _HomeState({required int initialPageIndex}) {
    _currentPage = initialPageIndex;
    _pageController = PageController(initialPage: initialPageIndex);
  }

  final List<String> _pageTitles = [
    'Home',
    'Body Mass Index',
    'Articles',
    'Plan Validity',
  ];

  final List<Color> _pageColorsHex = [
    const Color(0xFFA569BD),
    const Color(0xFF7FB3D5),
    const Color(0xFF73C6B6),
    const Color(0xFF82E0AA),
    const Color(0xFFF4D03F),
  ];

  final Color premiumTabColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Center(
          child: Text(
            _pageTitles[_currentPage],
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        backgroundColor: _currentPage == 3 ? premiumTabColor : Colors.blue,
        // Change the app bar color to green when Premium page is active
      ),
      body: PageView(
        controller: _pageController,
        children: [
          PremHomePage(),
          BMIPage(),
          ArticlesPage(),
          PlanValidity(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      bottomNavigationBar: BottomBar(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentPage = index;
          });
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeIconColor: Colors.black,
            activeColor: _pageColorsHex[_currentPage],
            activeTitleColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.calculate_rounded),
            title: const Text('BMI'),
            activeIconColor: Colors.black,
            activeColor: _pageColorsHex[_currentPage],
            activeTitleColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.text_snippet),
            title: const Text('Articles'),
            activeIconColor: Colors.black,
            activeColor: _pageColorsHex[_currentPage],
            activeTitleColor: Colors.black,
          ),
          BottomBarItem(
            icon: const Icon(Icons.access_time_filled_rounded),
            title: const Text('Plan Validity'),
            activeIconColor: _pageColorsHex[_currentPage],
            activeColor: _pageColorsHex[_currentPage],
            activeTitleColor: Colors.black,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaidFeed()),
          );
        },
        child: Icon(Icons.fitbit),
        backgroundColor: Color(0xFFD4AF37),
      ),
    );
  }
}
