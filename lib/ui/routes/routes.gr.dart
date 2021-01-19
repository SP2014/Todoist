// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:todoist/ui/pages/initialPage.dart';
import 'package:todoist/ui/pages/secondPage.dart';

class Router {
  static const initialPage = '/';
  static const secondPage = '/secondPage';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.initialPage:
        return MaterialPageRoute(
          builder: (_) => InitialPage(),
          settings: settings,
        );
      case Router.secondPage:
        return MaterialPageRoute(
          builder: (_) => SecondPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
