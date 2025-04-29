import 'package:flutter/material.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.text_snippet,color: Colors.grey,size: 100,),
            Text(
              'Coming Soon...',
              style: TextStyle(fontSize: 40,color: Colors.grey,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
