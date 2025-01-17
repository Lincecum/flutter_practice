import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const SensorApp(),
    );
  }
}

class SensorApp extends StatelessWidget {
  const SensorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]); // 가로모드 고정하는 방법 - 95
    final centerX = MediaQuery.of(context).size.width / 2 - 50; // 50 은 100의 절반
    final centerY = MediaQuery.of(context).size.height / 2 - 50; // 50 은 100의 절반

    return Scaffold(
        body: Stack(
         // 겹칠 수있고 원하는 모양대로 배치가 가능함
         children: [
         StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEvents,
            builder: (context, snapshot) {
              if (!snapshot.hasData) { // snapshot안에 데이터 숨겨져 있음
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final event = snapshot.data!;
              List<double> accelormeterValues = [event.x, event.y, event.z];
              print(accelormeterValues);

              return Positioned(
                // 원하는 위치로 컨테이너를 옮길 수 있음
                left: centerX + event.y * 20,
                top: centerY + event.x * 20,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color decoration null 이면 안된다는거 유의해야 함, 안쪽에만 컬러 사용해야함
                      color: Colors.yellow
                  ),
                  // color: Colors.lightGreen,
                  width: 100,
                  height: 100,
                ),
              );
            }),
      ],
    ));
  }
}
