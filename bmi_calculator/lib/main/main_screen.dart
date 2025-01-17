
import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>(); //form의 상태 가지고있는 것
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // 생명주기 메소드 initState dispose
  // 우리가 아래 코드를 재정의를 한것 이를 메소드 오버라이딩이라 함
  @override
  void initState() { // 앱이 시작되는 시점
    // TODO: implement initState
    super.initState();
    load(); // 화면이 처음 시작되는 부분
  }
  @override
  void dispose() {// 메모리 해제, 앱이 종료되는 시점
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  /*
    *  동기는 순서대로하는 거고 비동기는 누가 먼저 끝낼지 모르는 경우 오래 걸릴수 있는 함수를 쓸 때 await 를 씀 Future가 붙어있는 함수
    * */
  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async{
    final prefs = await SharedPreferences.getInstance(); // 앱 꺼도 저장하게 하기 위함
    final double? height = prefs.getDouble('height'); // ?은 null 값을 허용한다는 뜻
    final double? weight = prefs.getDouble('weight');
    if (height !=null && weight !=null){
      _heightController.text = '$height'; // type을 맞추기 위해 $
      _weightController.text = '$weight';
      print('키 : $height, 몸무게 : $weight');
    }
  }
  @override // 어딘가에서 정의를 미리해놓음
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // 꽉차지 않게 감싸는 것
        child: Form(
          key : _formKey, // form을 위한 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 끝으로 배치 상하가 Main 좌우는 cross
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '키'
                ),
                keyboardType: TextInputType.number,
                validator: (value){ // 입력값 검증
                  if(value ==null || value.isEmpty ){
                    return '키를 입력 하세요';
                  }
                  return null;
                },
              ),


              const SizedBox(height: 16),// 공백용
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
                  return; // 더 이상 진행 안되게 함
                }
                // final height = _heightController.text;
                // final weight = _weightController.text;'

                save(); // 안전하게 이때 진행 함

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
