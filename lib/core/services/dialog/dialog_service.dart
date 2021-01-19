import 'package:flutter/material.dart';

abstract class DialogService {
  GlobalKey<NavigatorState> get dialogNavigationKey;

  void registerDialogListener(Function(String) showDialogListener);

  Future<Map<String, dynamic>> showDialog({String type});

  Future<Map<String, dynamic>> showModalSheet({String type});

  void dialogComplete(Map<String, dynamic> result);
}
