import 'package:hive_flutter/hive_flutter.dart';
part 'todo.g.dart'; // 빨간 불 떠도 걍 진행

// 수정 시 flutter pub run build_runner build
@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  int? id; // nullable
  @HiveField(1)
  String title;
  @HiveField(2)
  int dateTime;

  @HiveField(3)
  bool isDone;

  Todo({required this.title, required this.dateTime, this.isDone = false,});
}
