import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:todoist/core/enums/view_state.dart';
import 'package:todoist/core/services/dialog/dialog_service.dart';
import 'package:todoist/core/viewmodels/main_viewmodel.dart';

import '../../locator.dart';

class InitialPage extends StatelessWidget {
  final dialogService = locator<DialogService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MainViewModel>.withoutConsumer(
      viewModel: MainViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('Home'),
        ),
        body: _Todos(),
        android: (_) => MaterialScaffoldData(
            floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            dialogService.showModalSheet(type: "simple").then((value) {
              if (value.length !=0) {
                model.add(value);
              }
            });
            //Router.navigator.pushNamed(Router.secondPage);
          },
        )),
      ),
    );
  }
}

class _NoTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Todos yet....'),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformCircularProgressIndicator(),
    );
  }
}

class _Todos extends ProviderWidget<MainViewModel> {
  @override
  Widget build(BuildContext context, MainViewModel model) {
    if (model.state == ViewState.Busy) {
      return _LoadingAnimation();
    }

    if (model.todos.isEmpty) {
      return _NoTodos();
    }

    return ListView.builder(
      itemCount: model.todos.length,
      
      itemBuilder: (context, index) => CheckboxListTile(
        value: model.todos[index].isCompleted,
        onChanged:(bool value){
          model.updateStatus(value, index);
        },
        controlAffinity: ListTileControlAffinity.leading,
        secondary: IconButton(
            iconSize: 24,
            icon: Icon(Icons.delete),
            onPressed: () {
              model.delete(index);
            }),
        title: Text(model.todos[index].title, style: TextStyle(decoration: model.todos[index].isCompleted ? TextDecoration.lineThrough : null)),
        key: Key('${model.todos[index].id}'),
      ),
    );
  }
}

// class InitialPage extends StatefulWidget{
//   _InitialPageState createState() => _InitialPageState();
// }

// class _InitialPageState extends State<InitialPage>{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Container(
//         child: Center(
//           child: RaisedButton(
//             onPressed: (){
//               Router.navigator.pushNamed(Router.secondPage);
//             },
//             child: Text('Second'),
//           )
//         ),
//       ),
//     );
//   }
// }
