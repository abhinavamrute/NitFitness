import 'package:flutter/material.dart';

/*
class Premium extends StatelessWidget {
  const Premium({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan, Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Advantages:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              AdvantageList(),
              SizedBox(height: 20),
              Text(
                'Choose a Subscription Plan:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: SubscriptionCard(
                      duration: _getDuration(index),
                      price: _getPrice(index),
                      savings: _getSavings(index),
                      description: _getDescription(index),
                      recommended: _isRecommended(index),
                      onPressed: _getOnPressedFunction(index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDuration(int index) {
    switch (index) {
      case 0:
        return '1 Month';
      case 1:
        return '3 Months';
      case 2:
        return '6 Months';
      default:
        return '';
    }
  }

  String _getPrice(int index) {
    switch (index) {
      case 0:
        return '\$14.99';
      case 1:
        return '\$24.99';
      case 2:
        return '\$39.99';
      default:
        return '';
    }
  }

  String _getSavings(int index) {
    switch (index) {
      case 0:
        return '';
      case 1:
        return 'Save 45%';
      case 2:
        return 'Save 55%';
      default:
        return '';
    }
  }

  String _getDescription(int index) {
    switch (index) {
      case 0:
        return 'Get started with our monthly plan.';
      case 1:
        return 'Most popular! Save with our 3-month plan.';
      case 2:
        return 'Ultimate value! Commit to 6 months and save.';
      default:
        return '';
    }
  }

  bool _isRecommended(int index) {
    return index == 1; // Mark 2nd item as recommended (index 1)
  }

  VoidCallback _getOnPressedFunction(int index) {
    switch (index) {
      case 0:
        return _subscribeOneMonth;
      case 1:
        return _subscribeThreeMonths;
      case 2:
        return _subscribeSixMonths;
      default:
        return () {}; // Empty function as fallback
    }
  }

  void _subscribeOneMonth() {
    print('Onclick: 1 Month plan');
    // Add logic here for 1 Month subscription
  }

  void _subscribeThreeMonths() {
    print('Onclick: 3 Months plan');
    // Add logic here for 3 Months subscription
  }

  void _subscribeSixMonths() {
    print('Onclick: 6 Months plan');
    // Add logic here for 6 Months subscription
  }
}

class SubscriptionCard extends StatelessWidget {
  final String duration;
  final String price;
  final String savings;
  final String description;
  final bool recommended;
  final VoidCallback onPressed;

  const SubscriptionCard({
    required this.duration,
    required this.price,
    required this.savings,
    required this.description,
    required this.recommended,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recommended)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(7), // Border radius of 5
                ),
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Text(
              duration,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: $price',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            if (savings.isNotEmpty)
              Text(
                savings,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 12.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(
                'Subscribe',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 4.0,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvantageList extends StatelessWidget {
  const AdvantageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        AdvantageItem(
          icon: Icons.check,
          text: 'Personalized Workout',
        ),
        AdvantageItem(
          icon: Icons.check,
          text: 'Workout Tracker',
        ),
        AdvantageItem(
          icon: Icons.check,
          text: 'AI Generated Diet Suggestions',
        ),
      ],
    );
  }
}

class AdvantageItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const AdvantageItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.0,
            color: Colors.green,
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold, // Bold style for the text
            ),
          ),
        ],
      ),
    );
  }
}

*/


class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.diamond,color: Color(0xFFD4AF37),size: 100,),
            Text(
              'Coming Soon...',
              style: TextStyle(fontSize: 40,color: Color(0xFFD4AF37),fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
