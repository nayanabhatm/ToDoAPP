import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/screens/tasks_list_screen.dart';
import 'model/task_list_model.dart';


void main() async{
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksList(),
      child: MaterialApp(
        title: 'ToDoApp',
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:TasksScreen()
      ),
    );
  }
}

