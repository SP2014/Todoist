import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget{
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second')
      ),
      body: Center(
        child: Text('Hello world'),
      ),
    );
  }
}