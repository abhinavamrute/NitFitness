import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';


class Extract extends StatefulWidget {
  const Extract({super.key});

  @override
  _ExtractState createState() => _ExtractState();
}

class _ExtractState extends State<Extract> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: [
                    Page1(pageController: _pageController),
                    Page2(
                      pageController: _pageController,
                      onBMICalculated: (double bmi) {
                        print('Calculated BMI: ${bmi.toStringAsFixed(2)}');
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: _buildDotIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return _buildDot(index);
      }),
    );
  }

  Widget _buildDot(int index) {
    Color color = _currentPageIndex == index ? Colors.blue : Colors.grey;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
