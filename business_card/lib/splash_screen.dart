import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/main');
    },);
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/business_card.jpeg',
            width: 180,
            height: 180,
          ),
          Container(
            margin: EdgeInsets.only(top:32),
            child: Text(
              'BusinessCard',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
