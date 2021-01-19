import 'package:todoist/core/models/todos/todos.dart';

abstract class TodosRepository{
  Future<List<Todos>> fetchTodos();
  Future<void> addTodos(Map<String,dynamic> todo);
  Future<void> deleteTodos(int id);
  void updateTodos(Map<String,dynamic> todo);

}