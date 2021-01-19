import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/navigator.dart';

import 'dialog_service.dart';

class DialogServiceImpl implements DialogService {

  final _dialogNavigationKey = GlobalKey<NavigatorState>();

  Function(String) _showDialogListener;
  Completer<Map<String, dynamic>> _dialogCompleter;

  @override
  void dialogComplete(Map<String, dynamic> result) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(result);
    _dialogCompleter = null;
  }

  @override
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  @override
  void registerDialogListener(Function(String type) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  @override
  Future<Map<String, dynamic>> showDialog({String type}) {
    _dialogCompleter = Completer<Map<String, dynamic>>();
    _showDialogListener(type);
    return _dialogCompleter.future;
  }

  @override
  Future<Map<String, dynamic>> showModalSheet({String type}) {
    _dialogCompleter = Completer<Map<String, dynamic>>();
    _showDialogListener(type);
    return _dialogCompleter.future;
  }
  
}