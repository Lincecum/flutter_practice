import 'package:flutter/material.dart';
import 'package:todolist/create_screen.dart';
import 'package:todolist/todo.dart';
import 'package:todolist/todo_item.dart';

import 'main.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // final todos = [
  //   Todo(title: 'title1', dateTime: 12321),
  //   Todo(title: 'title 2', dateTime: 12321),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOdo List'),
      ),
      body: ListView(
          children: todos.values // map 안됨
              .map((e) => TodoItem(
                        todo: e,
                        onTap: (todo) async {
                          todo.isDone = !todo.isDone;
                          await todo.save();
                          setState(() {});
                        },
                        onDelete: (todo) async {
                          await todo.delete();
                          setState(() {});
                        },
                      )
                  // ListTile(
                  // title: Text(todo.title),
                  // subtitle: Text('${todo.dateTime}'),
                  //   )
                  )
              .toList()

          // [
          //   ListTile(
          //     title: Text('title 1'),
          //     subtitle: Text('sub1'),
          //   ),
          //   ListTile(
          //     title: Text('title 2'),
          //     subtitle: Text('sub2'),
          //   ),
          // ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          );

          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
