import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/enums/connectivity_status.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'locator.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders

];

List<SingleChildWidget> independentServices = [];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<ConnectivityStatus>(
    create: (context) => locator<ConnectivityService>().connectivity$,
  ),
];