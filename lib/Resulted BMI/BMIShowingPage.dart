import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'flashscreen.dart';
import '../Home/Home.dart';


class ResultPage extends StatelessWidget {
  final double bmi;

  ResultPage({required this.bmi});

  // Navigation method to navigate to the Premium page
  void navigateToPremiumPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home(initialPageIndex: 1)), // Navigate to Premium page (index 3)
          (route) => false, // Prevent going back to the previous pages
    );
  }

  // Method to get the message based on BMI
  String getMessage() {
    if (bmi < 18.5) {
      return 'You are underweight.\nFocus on eating nutritious foods to gain weight in a healthy way. 💪';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Congratulations! You are in the healthy weight range.\nKeep up the good work! 🌟';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'You are overweight.\nConsider incorporating regular exercise and balanced meals into your routine for a healthier lifestyle. 🥗🏃‍♂️';
    } else {
      return 'You are obese.\nFocus on making positive lifestyle changes, such as exercising regularly and adopting a balanced diet, to improve your health and well-being. 🍉';
    }
  }

  // Method to get color based on BMI range
  Color _getBMIColor() {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return Colors.green;
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  // Method to get BMI status
  String _getBMIStatus() {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  // Method to get button label based on BMI range
  String _getButtonLabel() {
    if (bmi < 18.5) {
      return 'Get Personalized Weight Gain\nwith AI Diet';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Get Personalized Weight Maintenance\nwith AI Diet';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Get Personalized Weight Loss\nwith AI Diet';
    } else {
      return 'Get Personalized Overweight Management\nwith AI Diet';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
        title: Text(
          'BMI Result',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                height: 300,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 10,
                      maximum: 40,
                      ranges: <GaugeRange>[
                        GaugeRange(startValue: 10, endValue: 18.5, color: Colors.blue),
                        GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green),
                        GaugeRange(startValue: 24.9, endValue: 29.9, color: Colors.orange),
                        GaugeRange(startValue: 29.9, endValue: 40, color: Colors.red),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: bmi, enableAnimation: true),
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bmi.toStringAsFixed(2),
                                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: _getBMIColor()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                _getBMIStatus(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _getBMIColor()),
                              )
                            ],
                          ),
                          angle: 90,
                          positionFactor: 0.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              getMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 3,
                  ),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150),
                    alignment: Alignment.center,
                    child: Text(
                      'Retest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevent dialog from being dismissed
                      builder: (BuildContext context) {
                        return LoadingOverlay(
                          message: 'Creating Custom Plan',
                          progress: 0.0, // Initial progress
                        );
                      },
                    );

                    // Simulate loading process with a delay
                    Future.delayed(Duration(seconds: 7), () {
                      Navigator.pop(context); // Close the loading overlay
                      navigateToPremiumPage(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getBMIColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 3,
                  ),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150),
                    alignment: Alignment.center,
                    child: Text(
                      _getButtonLabel(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                          (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 3,
                  ),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 150),
                    alignment: Alignment.center,
                    child: Text(
                      '🏠 Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
