import 'dart:math';

import 'package:todoist/core/models/todos/todos.dart';
import 'package:todoist/core/models/todos/todos_h.dart';
import 'package:todoist/core/services/local_storage/local_storage_service.dart';
import 'package:todoist/locator.dart';

abstract class TodosLocalDataSource{
  List<Todos> fetchTodos();
  Future<void> addTodos(Map<String, dynamic> todos);
  void deleteTodos(int id);
  void updateTodos(Map<String, dynamic> todos);
}

class TodosLocalDataSourceImpl implements TodosLocalDataSource {
  final localStorageService = locator<LocalStorageService>();
  
  @override
  Future<void> addTodos(Map<String, dynamic> todos) async{
    TodosH t = TodosH.fromMap(todos);
    if(localStorageService.todosBox.isEmpty){
      t.id = Random().nextInt(100);
    }
    else{
      int len = localStorageService.todosBox.length-1;
      int lastIndex = localStorageService.todosBox.getAt(len).id;
      t.id = lastIndex+1;
    }
    localStorageService.todosBox.add(t);
 
  }

  @override
  void deleteTodos(int id) {
    print(id);
    localStorageService.todosBox.deleteAt(id);
    
  }

  @override
  List<Todos> fetchTodos() {
    if(localStorageService.todosBox.isEmpty){
      return [];
    }
    return localStorageService.todosBox.values
           .cast<TodosH>()
           .map((todosH) => Todos.fromMap(todosH.toMap()))
           .toList(); 
    
  }

  @override
  void updateTodos(Map<String, dynamic> todos) {
    int id = todos['id'];
    Map<String, dynamic> todo = localStorageService.todosBox.getAt(id).toMap();
    todos.forEach((key, value) {
      todo[key] = value;
    });
    TodosH newTodo = TodosH.fromMap(todo);
    localStorageService.todosBox.putAt(id, newTodo);
  }
  
}