import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'BMIPage.dart';
import 'ArticlesPage.dart';
import 'Premium.dart';

class Home extends StatefulWidget {
  final int initialPageIndex; // Define initialPageIndex parameter

  Home({Key? key, this.initialPageIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(initialPageIndex: initialPageIndex);
}

class _HomeState extends State<Home> {
  late int _currentPage;
  late PageController _pageController;

  _HomeState({required int initialPageIndex}) {
    _currentPage = initialPageIndex;
    _pageController = PageController(initialPage: initialPageIndex);
  }

  final List<String> _pageTitles = [
    //'Home',
    'Body Mass Index',
    //'Articles',
    'Get Premium',
  ];

  final List<Color> _pageColorsHex = [
    const Color(0xFFA569BD),
    const Color(0xFF7FB3D5),
    const Color(0xFF73C6B6),
    const Color(0xFF82E0AA),
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
          //HomePage(), // Add other pages here
          BMIPage(),
          //ArticlesPage(),
          Premium(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed, // Ensure even spacing
        items: <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: _pageColorsHex[0],
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'BMI',
            backgroundColor: _pageColorsHex[1],
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Articles',
            backgroundColor: _pageColorsHex[2],
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond_rounded),
            label: 'Premium',
            backgroundColor: _pageColorsHex[3],
          ),
        ],
      ),
    );
  }
}
