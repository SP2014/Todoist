import 'package:hive/hive.dart';
part 'todos_h.g.dart';

@HiveType(typeId: 0)
class TodosH extends HiveObject{

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  String category;

  @HiveField(5)
  String priority;

  @HiveField(6)
  String timestamp;

  TodosH({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.category,
    this.priority,
    this.timestamp
  });

  factory TodosH.fromMap(Map<String, dynamic> map){
    return new TodosH(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      category: map['category'],
      priority: map['priority'],
      timestamp: map['timestamp']
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['isCompleted'] = isCompleted;
    map['category'] = category;
    map['priority'] = priority;
    map['timestamp'] = timestamp;

    return map;
  }



}