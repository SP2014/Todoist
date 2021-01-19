import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:todoist/core/managers/core_manager.dart';
import 'package:todoist/core/services/dialog/dialog_service.dart';
import 'package:todoist/core/services/local_storage/local_storage_service.dart';
import 'package:todoist/locator.dart';
import 'package:todoist/provider_setup.dart';
import 'core/managers/dialog_manager.dart';
import 'core/utils/logger.dart';
import 'ui/routes/routes.gr.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();
  await setupLocator();
  await Future.wait([
    locator<LocalStorageService>().init()
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: CoreManager(
        child: PlatformApp(
          debugShowCheckedModeBanner: false,
          android: (_) => MaterialAppData(
            //theme: themes.primaryMaterialTheme,
            //darkTheme: themes.darkMaterialTheme,
          ),
          ios: (_) => CupertinoAppData(),
          title: 'Todoist',
          navigatorKey: Router.navigatorKey,
          onGenerateRoute: Router.onGenerateRoute,
          initialRoute: Router.initialPage,
          builder: _setupDialogManager,
        )
      ),
    );
  }

  Widget _setupDialogManager(context, widget){
    return Navigator(
      key: locator<DialogService>().dialogNavigationKey,
      onGenerateRoute: (settings) => platformPageRoute(
        context: context,
        builder: (context) => DialogManager(child: widget)
      )
    );
  }
}