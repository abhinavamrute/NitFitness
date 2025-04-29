import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  final ValueChanged<TimeOfDay?> onDismiss;

  WelcomePage({required this.onDismiss});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    // Set default time to 7:00 AM
    _selectedTime = TimeOfDay(hour: 7, minute: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to our Fitness App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Please select your preferred workout time:',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('Select Time'),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Time: ${_selectedTime.format(context)}', // Display selected time
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dismiss the WelcomePage and pass the selected time
                widget.onDismiss(_selectedTime);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to open time picker
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
