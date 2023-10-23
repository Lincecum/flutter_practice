import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;

  const ResultScreen({
    Key? key,
    required this.height,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결과'),
        ),
      body: Center(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('정상', style: TextStyle(fontSize: 36),),
            Icon(Icons.sentiment_neutral, color:Colors.amber, size: 100,),
          ],
        ),
      ),
    );
  }
}
