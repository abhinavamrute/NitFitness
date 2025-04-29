import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  final PageController pageController;

  const Page1({super.key, required this.pageController});

  @override
  _Page1State createState() => _Page1State();
}


class _Page1State extends State<Page1> with AutomaticKeepAliveClientMixin<Page1> {
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  int _selectedAge = 5;

  bool get isGenderSelected => _isMaleSelected || _isFemaleSelected;

  @override
  bool get wantKeepAlive => true; // Keep the state alive when navigating away from this page

  void _selectGender(bool isMale) {
    setState(() {
      _isMaleSelected = isMale;
      _isFemaleSelected = !isMale;
    });
  }

  void _checkButtonState() {
    // Implement your button state checking logic here
  }

  void _navigateToNextPage() {
    if (!isGenderSelected) {
      // If no gender is selected, do not navigate
      return;
    }

    // Determine the selected gender text based on the boolean flags
    String selectedGender = _isMaleSelected ? 'Male' : 'Female';

    // Print the selected gender and age
    print('Selected Gender: $selectedGender');
    print('Selected Age: $_selectedAge');

    // Navigate to the next page using the provided PageController
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );

    // Pass selected age (height) back to parent widget
    (_selectedAge.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super build method to maintain state

    return Container(
      color: const Color(0xFFF7F7F9), // Example background color
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Welcome to the NitFit App',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Please Enter following details',
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Gender',
                        style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectGender(true),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _isMaleSelected ? Colors.blue : Colors.grey,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.man_outlined,
                                      size: 100,
                                      color: _isMaleSelected ? Colors.blue : null,
                                    ),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: _isMaleSelected ? Colors.blue : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectGender(false),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _isFemaleSelected ? Colors.pink : Colors.grey,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.woman,
                                      size: 100,
                                      color: _isFemaleSelected ? Colors.pink : null,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: _isFemaleSelected ? Colors.pink : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Age',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          height: 80,
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: 3,
                                child: ListWheelScrollView(
                                  diameterRatio: 2.5,
                                  itemExtent: 80,
                                  physics: const FixedExtentScrollPhysics(),
                                  children: List.generate(
                                    116,
                                        (index) => RotatedBox(
                                      quarterTurns: 1,
                                      child: Center(
                                        child: Text(
                                          (index + 5).toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: index + 5 == _selectedAge
                                                ? Colors.black
                                                : Colors.black.withOpacity(0.25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      _selectedAge = index + 5;
                                    });
                                    _checkButtonState();
                                  },
                                ),
                              ),
                              const Positioned(
                                top: -7,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 70, right: 25),
                  child: ElevatedButton(
                    onPressed: isGenderSelected ? _navigateToNextPage : null,
                    // Disable the button if gender is not selected
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


