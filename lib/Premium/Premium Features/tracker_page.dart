import 'package:flutter/material.dart';
import 'exercise_panel.dart'; // Import ExercisePanel from exercise_panel.dart

class TrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker'),
      ),
      body: Container(
        color: Color(0xFFF7F7F9),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns as needed
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 30, // Total days to display
                itemBuilder: (BuildContext context, int index) {
                  // Calculate the day number (1-based index)
                  int dayNumber = index + 1;


                  bool isRestDay = (dayNumber % 5 == 0);

                  // Return appropriate widget based on the day type
                  if (isRestDay) {
                    return GestureDetector(
                      onTap: () {
                        // Show system pop-up dialog for "Rest Day"
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Rest Day'),
                              content: Text('Take a break! It\'s a rest day.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: RestDayWidget(),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to exercise panel route on day box tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePanel(dayNumber: dayNumber),
                          ),
                        );
                      },
                      child: DayWidget(dayNumber: dayNumber),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final int dayNumber;

  DayWidget({required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          '$dayNumber',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class RestDayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Icon(Icons.coffee, color: Colors.white, size: 50),
      ),
    );
  }
}