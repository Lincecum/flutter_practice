import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int cnt = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('홈'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Number',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              Text(
                '$cnt',
                style: TextStyle(color: Colors.red, fontSize: 70),
              ),
              ElevatedButton(onPressed: () {print('ElevatedButton');}, child: Text('ElevatedButton'),),
              TextButton(onPressed: () {print('TextButton');}, child: Text('TextButton'),),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 화면 갱신
          setState(() {
            cnt ++;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
