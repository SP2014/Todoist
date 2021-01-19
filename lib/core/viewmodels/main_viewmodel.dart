import 'package:todoist/core/enums/view_state.dart';
import 'package:todoist/core/models/todos/todos.dart';
import 'package:todoist/core/repositories/todos_repository/todos_repository.dart';
import 'package:todoist/locator.dart';
import 'package:todoist/core/exceptions/repository_exception.dart';

import 'base_viewmodel.dart';

class MainViewModel extends BaseViewmodel {
  final _todosRepository = locator<TodosRepository>();

  List<Todos> _todos = [];
  List<Todos> get todos => _todos;

  Future<void> init() async{
    setState(ViewState.Busy);
    try{
      final fetchedTodos = await _todosRepository.fetchTodos();
      _todos = fetchedTodos.toList();
    } on RepositoryException{
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }

  Future<void> add(Map<String, dynamic> todo) async{
    setState(ViewState.Busy);
    todo['timestamp'] = todo['date'] + ' '+ todo['time'];
    todo['isCompleted'] = false;
    todo['category'] = 'General';
    todo['priority'] = 'High';
    await _todosRepository.addTodos(todo);
    _todos = await _todosRepository.fetchTodos();
    setState(ViewState.Idle);
  }

  Future<void> updateStatus(bool v, int idx) async {
    var d = <String, dynamic>{};
    d['id'] = idx;
    d['isCompleted'] = v;
    _todosRepository.updateTodos(d);
    _todos = await _todosRepository.fetchTodos();
    setState(ViewState.Idle);
  } 

  Future<void> delete(int id) async {
    await _todosRepository.deleteTodos(id);
    _todos.removeAt(id);
    setState(ViewState.Idle);
  }
  
}