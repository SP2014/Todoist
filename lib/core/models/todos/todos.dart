import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'todos.g.dart';

abstract class Todos implements Built<Todos, TodosBuilder>{
 int get id;
 String get title;
 String get description;
 bool get isCompleted;
 String get category;
 String get priority;
 String get timestamp;

 set isCompleted(bool v) => isCompleted = v;

String toJson(){
  return json.encode(serializers.serializeWith(Todos.serializer, this));
}

 static Todos fromMap(Map<String, dynamic> map){
   return serializers.deserializeWith(
     Todos.serializer,
     map,
   );
 } 

 Todos._();
 static Serializer<Todos> get serializer => _$todosSerializer;
 factory Todos([void Function(TodosBuilder) updates]) = _$Todos;
}