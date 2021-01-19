import 'package:hive/hive.dart';
import 'package:todoist/core/models/todos/todos_h.dart';
import 'package:todoist/core/utils/logger.dart';
import 'package:todoist/core/utils/file_utils.dart' as file_utils;

import 'local_storage_service.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  Box<TodosH> _todosBox;
  Box<TodosH> get todosBox => _todosBox;

  Future<void> init() async {
    try{
      final path = await file_utils.getApplicationDocumentsDirectoryPath();
      Hive
        ..init(path)
        ..registerAdapter(TodosHAdapter());
    } on HiveError catch (e){
      Logger.w('LocalStorageService: ${e.message}', e: e, s: e.stackTrace);
    }

    _todosBox = await Hive.openBox<TodosH>('todos');
  }
  
}