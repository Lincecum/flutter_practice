
import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  @override
  void dispose() {

    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async{
    final prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height'); // ?은 null 값을 허용한다는 뜻
    final double? weight = prefs.getDouble('weight');
    if (height !=null && weight !=null){
      _heightController.text = '$height';
      _weightController.text = '$weight';
      print('키 : $height, 몸무게 : $weight');
    }
  }
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
                controller: _heightController,
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


              const SizedBox(height: 16),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '몸무게'
                ),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value ==null || value.isEmpty ){
                    return '몸무게를 입력 하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState?.validate() == false ){
                  return;
                }
                // final height = _heightController.text;
                // final weight = _weightController.text;'

                save();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          height: double.parse(_heightController.text),
                          weight: double.parse(_weightController.text),))
                );
              }, child: const Text('결과')),
            ],
          ),
        ),
      ),
    );
  }
}
