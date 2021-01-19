import 'package:hive/hive.dart';
import 'package:todoist/core/models/todos/todos_h.dart';

abstract class LocalStorageService{
  Future<void> init();

  Box<TodosH> get todosBox;

}