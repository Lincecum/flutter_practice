
import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key : _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키'
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value ==null || value.isEmpty ){
                    return '키를 입력 하세요';
                  }
                  return null;
                },
              ),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState?.validate() ?? false){
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultScreen(
                      height: 185, weight: 88,))
                );
              }, child: const Text('결과')),

              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '몸무게'
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState?.validate() ?? false){

                }
              }, child: const Text('결과'))
            ],
          ),
        ),
      ),
    );
  }
}
