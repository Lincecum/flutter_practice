import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onTap;
  final Function(Todo) onDelete;

  const TodoItem({Key? key, required this.todo, required this.onTap, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onTap(todo);
        },
        leading: todo.isDone
            ? const Icon(
                Icons.check_circle,
                color: Colors.red,
              )
            : const Icon(
                Icons.check_circle_outline,
              ),
        title: Text(
          todo.title,
          style: TextStyle(color: todo.isDone ? Colors.grey : Colors.purple),
        ),
        subtitle: Text(
            DateFormat.yMMMd()
                .format(DateTime.fromMillisecondsSinceEpoch(todo.dateTime)),
            style: TextStyle(color: todo.isDone ? Colors.grey : Colors.purple)),
        // flutter pub add intl
        trailing: todo.isDone ? GestureDetector(onTap: () { onDelete(todo);}, child: const Icon(Icons.delete_forever),) : null);
  }
}
