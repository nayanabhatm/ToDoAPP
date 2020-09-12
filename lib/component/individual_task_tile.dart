import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/task_list_model.dart';
import 'package:to_do_app/screens/add_task_screen.dart';

class IndividualTaskTile extends StatelessWidget {
  final String taskTitle,taskDescription;
  final int index,dateTimeValue;

  IndividualTaskTile({this.taskTitle,this.taskDescription,this.index,this.dateTimeValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
          print("sxx");
      },
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => AddTaskScreen(title:taskTitle,description:taskDescription,index:index,dateTimeValue:dateTimeValue)));
      },
      child: Card(
        elevation: 6.0,
        child: ListTile(
          title: Text(
            taskTitle,
            //textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          subtitle: Text(
            taskDescription,
          ),
          trailing: IconButton(
            icon:Icon(Icons.delete),
            color: Colors.deepPurpleAccent,
            iconSize: 32.0,
            onPressed: (){
              showDialog(context: context, child:
              new AlertDialog(
                title: new Text("Delete the ToDo Permanently ?"),
                actions: [
                  RaisedButton(
                     child: Text("Yes"),
                      color: Colors.deepPurpleAccent,
                      onPressed:(){
                          Provider.of<TasksList>(context,listen: false).deleteTask(dateTimeValue);
                          Navigator.pop(context);
                      }),
                  RaisedButton(
                      child: Text("No"),
                      color: Colors.deepPurpleAccent,
                      onPressed:(){
                          Navigator.pop(context);
                      })
                ],
                )
              );
            },
          ),
        ),
      ),
    );
  }
}