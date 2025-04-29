import 'dart:async';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  final String message;
  final double progress; // Value between 0.0 and 1.0 indicating loading progress

  LoadingOverlay({required this.message, required this.progress});

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  late String displayMessage;

  @override
  void initState() {
    super.initState();

    // Start a timer to change the display message after 3 seconds
    Timer(Duration(seconds: 3), () {
      setState(() {
        displayMessage = 'Generating AI Diet Plan'; // Update the message
      });

      // Start another timer to change the message again after a short delay
      Timer(Duration(seconds: 3), () {
        setState(() {
          displayMessage = 'Almost there'; // Update the message again
        });
      });
    });

    // Initialize the display message with the original message
    displayMessage = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Semi-transparent black color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade400, Colors.blue.shade800],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  displayMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                // AnimatedOpacity can be used to control opacity with an animation
                AnimatedOpacity(
                  opacity: displayMessage == 'Generating AI Diet Plan' ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Text(
                    'Creating Personalized Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
