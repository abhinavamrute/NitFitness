import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: SwipeSlider(),
  ));
}

class SwipeSlider extends StatelessWidget {
  const SwipeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Suggested Diet Plan'),
        backgroundColor: Color(0xFFF7F7F9),
      ),
      body: DietForm(),
    );
  }
}

class DietForm extends StatefulWidget {
  const DietForm({Key? key}) : super(key: key);

  @override
  _DietFormState createState() => _DietFormState();
}

class _DietFormState extends State<DietForm> {
  final MethodChannel _channel = MethodChannel('diet_plan_channel');
  String? dietPlan;

  void submitForm() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod('generateDietPlan', {
        'age': '25', // Example: Replace with actual user input
        'goal': 'Lose', // Example: Replace with actual user input
        'weightChange': '5', // Example: Replace with actual user input
        'mealType': 'Mexican', // Example: Replace with actual user input
        'mealPreference': 'Non-Vegetarian', // Example: Replace with actual user input
      });

      setState(() {
        dietPlan = result['dietPlan'] as String?;
      });

      // Navigate to DietPlan screen after receiving diet plan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DietPlan(dietPlan: dietPlan)),
      );
    } on PlatformException catch (e) {
      print('Failed to generate diet plan: ${e.message}');
      // Handle error if method invocation fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: submitForm,
        child: Text('Generate Diet Plan'),
      ),
    );
  }
}

class DietPlan extends StatelessWidget {
  final String? dietPlan;

  const DietPlan({Key? key, this.dietPlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plan'),
        backgroundColor: Color(0xFFF7F7F9),
      ),
      body: Center(
        child: Text(
          dietPlan ?? 'Loading...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
