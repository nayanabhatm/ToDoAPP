import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/component/individual_task_tile.dart';
import 'package:to_do_app/model/task_list_model.dart';
import 'package:to_do_app/screens/add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TasksList>(context).getTaskList();
    return Scaffold(
          appBar: AppBar(
            title: Text(
              "TODOApp",
            ),
          ),
          body: Consumer<TasksList>(
            builder: (context,todoTask,child) =>
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                          itemCount: todoTask.tasksCount,
                          itemBuilder: (BuildContext context,int index){
                          return IndividualTaskTile(
                                taskTitle: todoTask.tasks[index].title,
                                taskDescription:todoTask.tasks[index].description,
                                index:index,
                                dateTimeValue: todoTask.tasks[index].dateTime,
                            );
                          },
                      ),
              ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
            },
            tooltip: "Add Task",
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(
              Icons.add,
              size: 40.0,
            ),
          ),
        );

  }
}


