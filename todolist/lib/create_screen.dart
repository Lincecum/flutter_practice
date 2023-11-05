import 'package:flutter/material.dart';
import 'package:todolist/todo.dart';

import 'main.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _textcontroller = TextEditingController();

  @override
  void dispose() {
    _textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo 작성 '),
        actions: [
          IconButton(
            onPressed: () async{
              await todos.add(Todo(
                title: _textcontroller.text,
                dateTime: DateTime.now().millisecondsSinceEpoch,
              ));
              if(mounted){ // 화면 수행 확인해서 안정
                Navigator.pop(context); // 뒤로가기 시 await 해줘야함
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textcontroller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.brown),
              hintText: 'Type what u wanna do ',
              filled: true,
              fillColor: Colors.white10),
        ),
      ),
    );
  }
}
