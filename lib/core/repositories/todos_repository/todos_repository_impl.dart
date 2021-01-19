import 'package:todoist/core/data_sources/todos/todos_local_data_source.dart';
import 'package:todoist/core/models/todos/todos.dart';
import 'package:todoist/locator.dart';

import 'todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {

  final localDataSource = locator<TodosLocalDataSource>();

  @override
  Future<void> addTodos(Map<String, dynamic> todo) async {
    await localDataSource.addTodos(todo);
  }

  @override
  Future<void> deleteTodos(int id) async{
    localDataSource.deleteTodos(id);
  }

  @override
  Future<List<Todos>> fetchTodos() async {
    final todos = localDataSource.fetchTodos();
    return todos;
  }

  @override
  void updateTodos(Map<String, dynamic> todo) {
    localDataSource.updateTodos(todo);
  }
  
}