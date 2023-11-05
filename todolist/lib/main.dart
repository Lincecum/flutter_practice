import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/list_screen.dart';
import 'package:todolist/todo.dart';

late Box<Todo> todos;

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  todos = await Hive.openBox<Todo>('todolist.db');
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
      home: const ListScreen(),
    );
  }
}
