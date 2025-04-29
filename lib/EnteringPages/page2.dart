import 'package:flutter/material.dart';
import '../Resulted BMI/BMIShowingPage.dart';

class FormData extends ChangeNotifier {
  String feet = '';
  String inches = '';
  String cm = '';
  String kg = '';
  String lbs = '';
}

class Page2 extends StatefulWidget {
  final PageController pageController;
  final Function(double) onBMICalculated; // Callback for BMI calculation

  const Page2({
    required this.pageController,
    required this.onBMICalculated,
    Key? key,
  }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<bool> isHeightSelected = [true, false];
  List<bool> isWeightSelected = [true, false];
  bool _isImperial = true;
  late FormData _formData;
  bool _isFormValid = false;

  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  TextEditingController cmController = TextEditingController();
  TextEditingController kgController = TextEditingController();
  TextEditingController lbsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formData = FormData();
  }

  @override
  void dispose() {
    feetController.dispose();
    inchesController.dispose();
    cmController.dispose();
    kgController.dispose();
    lbsController.dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    setState(() {
      if (_isImperial) {
        _isFormValid = (feetController.text.isNotEmpty &&
            (inchesController.text.isEmpty || inchesController.text.isNotEmpty) &&
            (kgController.text.isNotEmpty || lbsController.text.isNotEmpty));
      } else {
        _isFormValid = (cmController.text.isNotEmpty &&
            (kgController.text.isNotEmpty || lbsController.text.isNotEmpty));
      }
    });
  }

  void _navigateToNextPage() {
    if (_isFormValid) {
      try {
        double heightInMeters;
        double weightInKg;

        if (_isImperial) {
          // Calculate height in cm from feet and inches
          double feet = double.parse(feetController.text);
          double inches = double.parse(inchesController.text.isNotEmpty ? inchesController.text : '0');
          double heightInCm = (feet * 30.48) + (inches * 2.54);
          heightInMeters = heightInCm / 100;
        } else {
          // Calculate height directly in meters from centimeters
          heightInMeters = double.parse(cmController.text) / 100;
        }

        // Determine weight in kg based on selected unit
        if (isWeightSelected[0]) {
          weightInKg = double.parse(kgController.text);
        } else {
          // Convert pounds to kg
          weightInKg = double.parse(lbsController.text) * 0.453592;
        }

        // Calculate BMI using heightInMeters and weightInKg
        double bmi = weightInKg / (heightInMeters * heightInMeters);

        // Call the BMI calculation callback
        widget.onBMICalculated(bmi);

        // Navigate to ResultPage with calculated BMI
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(bmi: bmi),
          ),
        );
      } catch (e) {
        print('Error calculating BMI: $e');
        print('Please check your input values.');
      }
    } else {
      print('Please fill in all required fields.');
    }
  }


  void _navigateToPreviousPage() {
    widget.pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Please Enter the following details',
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
              child: Container(
                height: 150,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Height',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: ToggleButtons(
                                  borderRadius: BorderRadius.circular(5),
                                  isSelected: isHeightSelected,
                                  color: Colors.blue,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.blue,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                      buttonIndex < isHeightSelected.length;
                                      buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isHeightSelected[buttonIndex] = true;
                                          _isImperial = index == 0;
                                          _updateFormValidity();
                                        } else {
                                          isHeightSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  children: <Widget>[
                                    Text(
                                      'ft-in',
                                      style: TextStyle(
                                          color: isHeightSelected[0]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                    Text(
                                      'cm',
                                      style: TextStyle(
                                          color: isHeightSelected[1]
                                              ? Colors.white
                                              : Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_isImperial)
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: feetController,
                                onChanged: (value) {
                                  _formData.feet = value;
                                  _updateFormValidity();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Feet',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintStyle: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: inchesController,
                                onChanged: (value) {
                                  _formData.inches = value;
                                  _updateFormValidity();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Inches',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintStyle: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (!_isImperial)
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: cmController,
                          onChanged: (value) {
                            _formData.cm = value;
                            _updateFormValidity();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Centimeters',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintStyle: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Weight selection
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 11),
              child: Container(
                height: 150,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Weight',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: ToggleButtons(
                                  borderRadius: BorderRadius.circular(5),
                                  isSelected: isWeightSelected,
                                  color: Colors.blue,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.blue,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                      buttonIndex < isWeightSelected.length;
                                      buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isWeightSelected[buttonIndex] = true;
                                        } else {
                                          isWeightSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  children: <Widget>[
                                    Text(
                                      'kg',
                                      style: TextStyle(
                                          color: isWeightSelected[0]
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                    Text(
                                      'lbs',
                                      style: TextStyle(
                                          color: isWeightSelected[1]
                                              ? Colors.white
                                              : Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (isWeightSelected[0])
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                controller: kgController,
                                onChanged: (value) {
                                  _formData.kg = value;
                                  _updateFormValidity();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Weight (kg)',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintStyle: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isWeightSelected[1])
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: lbsController,
                          onChanged: (value) {
                            _formData.lbs = value;
                            _updateFormValidity();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Weight (lbs)',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintStyle: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _navigateToPreviousPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _navigateToNextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      _isFormValid ? Colors.blue : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
