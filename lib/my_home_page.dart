import 'package:flutter/material.dart';

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
            TextField(
                decoration: InputDecoration(labelText: '글자', border: OutlineInputBorder()),
              onChanged: (text) {
               print(text);
              },
            ),
            // Image.network(URL)
            Container(color: Colors.red,
              child: Padding(padding: const EdgeInsets.all(8.0), child : Image.asset('assets/rabbit.jpeg', width:100,height:100, fit : BoxFit.cover)),)
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