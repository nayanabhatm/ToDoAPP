import 'package:flutter/cupertino.dart';
import 'package:to_do_app/database_helper.dart';
import 'package:to_do_app/model/task_model.dart';

class TasksList extends ChangeNotifier{
  List<Task> _tasks=[];

  int get tasksCount => _tasks.length;
  List<Task> get tasks => _tasks;

  final dbHelper = DatabaseHelper.instance;

  void addNewTask(String title, String description,bool isSelected)async{
    _insert(title, description);
    notifyListeners();
  }


  void updateTask(int index,String title,String description,int prevDatetime){
    _update(title, description,index,prevDatetime);
    notifyListeners();
  }

  void getTaskList() async{
    await _query();
    notifyListeners();
  }

  void deleteTask(int dateTimeValue){
    _delete(dateTimeValue);
    notifyListeners();
  }


  void _insert(String title, String description) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.title : title,
      DatabaseHelper.description  : description,
      DatabaseHelper.dateTime : (new DateTime.now()).millisecondsSinceEpoch,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future _query() async {
    final allRows = await dbHelper.queryAllRows();
    _tasks=[];
    allRows.forEach((row){
         //print("$row");
         var tempList=row.values.toList();
         _tasks.add(Task(title:tempList[1],description: tempList[2],dateTime:tempList[3]));
     }
    );
  }

  void _update(String title, String description,int index,int prevDatetime) async {
    print("update $index, $title,$prevDatetime---------------");
    Map<String, dynamic> row = {
      DatabaseHelper.title : title,
      DatabaseHelper.description  : description,
      DatabaseHelper.dateTime : (new DateTime.now()).millisecondsSinceEpoch,
    };
    final rowsAffected = await dbHelper.update(row,prevDatetime);
    print(rowsAffected);
  }

  void _delete(int dateTimeValue) async {
    final rowsDeleted = await dbHelper.delete(dateTimeValue);
    print('deleted $rowsDeleted row(s)');
  }

}