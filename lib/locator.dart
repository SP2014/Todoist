import 'package:get_it/get_it.dart';
import 'package:todoist/core/data_sources/todos/todos_local_data_source.dart';
import 'package:todoist/core/services/dialog/dialog_service.dart';

import 'core/repositories/todos_repository/todos_repository.dart';
import 'core/repositories/todos_repository/todos_repository_impl.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/connectivity/connectivity_service_impl.dart';
import 'core/services/dialog/dialog_service_impl.dart';
import 'core/services/http/http_service.dart';
import 'core/services/http/http_service_impl.dart';
import 'core/services/local_storage/local_storage_service.dart';
import 'core/services/local_storage/local_storage_service_impl.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async{
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(),
  );
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());

  // Data Sources
  locator.registerLazySingleton<TodosLocalDataSource>(
    () => TodosLocalDataSourceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<TodosRepository>(() => TodosRepositoryImpl());
}