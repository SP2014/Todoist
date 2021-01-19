import 'package:auto_route/auto_route_annotations.dart';
import 'package:todoist/ui/pages/initialPage.dart';
import 'package:todoist/ui/pages/secondPage.dart';


@autoRouter
class $Router{
  @initial
  InitialPage initialPage;
  @MaterialRoute(fullscreenDialog: true)
  SecondPage secondPage;
}