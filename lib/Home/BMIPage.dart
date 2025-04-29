import 'package:flutter/material.dart';
import '../Resulted BMI/BMIShowingPage.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({Key? key}) : super(key: key);

  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;

  int _selectedAge = 18;

  List<bool> isHeightSelected = [true, false];
  List<bool> isWeightSelected = [true, false];

  bool _isImperial = true;

  late TextEditingController _feetController;
  late TextEditingController _inchesController;
  late TextEditingController _cmController;
  late TextEditingController _kgController;
  late TextEditingController _lbsController;

  bool _buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _feetController = TextEditingController();
    _inchesController = TextEditingController();
    _cmController = TextEditingController();
    _kgController = TextEditingController();
    _lbsController = TextEditingController();
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    _cmController.dispose();
    _kgController.dispose();
    _lbsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gender selection
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  height: 210,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Gender',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isMaleSelected = true;
                                  _isFemaleSelected = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _isMaleSelected
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Icon(
                                        Icons.man_outlined,
                                        size: 100,
                                        color: _isMaleSelected
                                            ? Colors.blue
                                            : null,
                                      ),
                                      Text(
                                        'Male',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: _isMaleSelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isFemaleSelected = true;
                                  _isMaleSelected = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _isFemaleSelected
                                          ? Colors.pink
                                          : Colors.grey,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Icon(
                                        Icons.woman,
                                        size: 100,
                                        color: _isFemaleSelected
                                            ? Colors.pink
                                            : null,
                                      ),
                                      Text(
                                        'Female',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: _isFemaleSelected
                                              ? Colors.pink
                                              : Colors.grey,
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
              ), //Gender
              // Age selection
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              border: Border.all(color: Colors.blue),
                            ),
                            height: 80,
                            child: Stack(
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: ListWheelScrollView(
                                    diameterRatio: 2.5,
                                    itemExtent: 80,
                                    physics: FixedExtentScrollPhysics(),
                                    children: List.generate(
                                      116,
                                          (index) =>
                                          RotatedBox(
                                            quarterTurns: 1,
                                            child: Center(
                                              child: Text(
                                                (index + 5).toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: index + 5 ==
                                                      _selectedAge ? Colors
                                                      .black : Colors.black
                                                      .withOpacity(0.25),
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
                                Positioned(
                                  top: -7,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.blue,
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
              ), //Age
              // Height selection
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
                                        for (int buttonIndex = 0; buttonIndex <
                                            isHeightSelected
                                                .length; buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isHeightSelected[buttonIndex] =
                                            true;
                                            _isImperial = index == 0;
                                          } else {
                                            isHeightSelected[buttonIndex] =
                                            false;
                                          }
                                        }
                                      });
                                      _checkButtonState();
                                    },
                                    children: <Widget>[
                                      Text(
                                        'ft-in',
                                        style: TextStyle(
                                            color: isHeightSelected[0] ? Colors
                                                .white : Colors.grey),
                                      ),
                                      Text(
                                        'cm',
                                        style: TextStyle(
                                            color: isHeightSelected[1] ? Colors
                                                .white : Colors.grey),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: TextField(
                                  controller: _feetController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _checkButtonState();
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Feet',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue),
                                    ),
                                    hintStyle: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: TextField(
                                  controller: _inchesController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _checkButtonState();
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Inches',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _cmController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _checkButtonState();
                            },
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
              ), //Height
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
                                        for (int buttonIndex = 0; buttonIndex <
                                            isWeightSelected
                                                .length; buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isWeightSelected[buttonIndex] =
                                            true;
                                          } else {
                                            isWeightSelected[buttonIndex] =
                                            false;
                                          }
                                        }
                                      });
                                      _checkButtonState();
                                    },
                                    children: <Widget>[
                                      Text(
                                        'kg',
                                        style: TextStyle(
                                            color: isWeightSelected[0] ? Colors
                                                .white : Colors.grey),
                                      ),
                                      Text(
                                        'lbs',
                                        style: TextStyle(
                                            color: isWeightSelected[1] ? Colors
                                                .white : Colors.grey),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: TextField(
                                  controller: _kgController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _checkButtonState();
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Weight (kg)',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _lbsController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              _checkButtonState();
                            },
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
              // Calculate button
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _buttonEnabled ? _calculateBMI : null,
                        child: Text(
                          'Calculate',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _buttonEnabled ? Colors.blue : Colors.grey),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateBMI() {
    // Gender selection
    String gender = _isFemaleSelected ? 'Female' : 'Male';
    print('Gender: $gender');

    // Age selection
    int age = _selectedAge;
    print('Age: $age');

    // Height selection
    double heightInMeters;
    if (_isImperial) {
      double feet = double.parse(_feetController.text);
      double inches = double.parse(_inchesController.text);
      double totalInches = (feet * 12) + inches;
      heightInMeters = totalInches * 0.0254;
    } else {
      double cm = double.parse(_cmController.text);
      heightInMeters = cm / 100;
    }
    print('Height: ${heightInMeters.toStringAsFixed(2)} meters');

    // Weight selection
    double weight = double.parse(_getWeight());
    print('Weight: ${weight} kg');

    // Calculate BMR based on gender
    double bmr;
    if (_isFemaleSelected) {
      // BMR formula for females
      bmr = 447.593 + (9.247 * weight) + (3.098 * (heightInMeters * 100)) - (4.330 * age);
    } else {
      // BMR formula for males
      bmr = 88.362 + (13.397 * weight) + (4.799 * (heightInMeters * 100)) - (5.677 * age);
    }
    print('BMR: ${bmr.toStringAsFixed(2)} calories/day');

    // Navigate to result page with BMI and BMR
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          bmi: _calculateBMIValue(weight, heightInMeters),
        ),
      ),
    );
  }

// Helper function to calculate BMI
  double _calculateBMIValue(double weight, double heightInMeters) {
    return weight / (heightInMeters * heightInMeters);
  }


  String _getWeight() {
    if (isWeightSelected[0]) {
      // Kilograms
      return _kgController.text;
    } else {
      // Pounds converted to kilograms
      double lbs = double.parse(_lbsController.text);
      double kg = lbs * 0.453592;
      return kg.toStringAsFixed(2);
    }
  }

  void _checkButtonState() {
    setState(() {
      bool heightEntered = false;
      bool weightEntered = false;

      if (_isImperial) {
        heightEntered = _feetController.text.isNotEmpty && _inchesController.text.isNotEmpty;
      } else {
        heightEntered = _cmController.text.isNotEmpty;
      }

      if (isWeightSelected[0]) {
        weightEntered = _kgController.text.isNotEmpty;
      } else if (isWeightSelected[1]) {
        weightEntered = _lbsController.text.isNotEmpty;
      }

      if (heightEntered && weightEntered && _selectedAge > 0) {
        _buttonEnabled = true;
      } else {
        _buttonEnabled = false;
      }
    });
  }

}

