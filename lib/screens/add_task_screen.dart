import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/task_list_model.dart';


class AddTaskScreen extends StatefulWidget {
  final String title,description;
  final int index,dateTimeValue;
  AddTaskScreen({this.title, this.description,this.index,this.dateTimeValue});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerValue=Provider.of<TasksList>(context,listen: false);
    titleController.text=widget.title;
    descriptionController.text=widget.description;
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) =>
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(18.0),
                    child: TextFormField(
                      validator: (String value){
                        if(value.isEmpty )
                          return "Title Can't be empty";
                        return null;
                      },
                      controller: titleController,
                      minLines: 1,
                      decoration: textFieldBorderDecoration("Task Title"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:18.0,right: 18.0,bottom: 18.0),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: textFieldBorderDecoration("Task Description"),
                      maxLength: 2000,
                      maxLines: 5,
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 400) ,
                          content: Text('Task Saved!'),
                          backgroundColor: Colors.deepPurpleAccent,
                        ));
                        if(widget.title!=null && widget.title.length > 0){
                          providerValue.updateTask(widget.index,titleController.text,descriptionController.text,widget.dateTimeValue);}
                        else
                          providerValue.addNewTask(titleController.text, descriptionController.text ?? '',false);
                        Timer(Duration(milliseconds: 470), (){
                            Navigator.pop(context);
                        });
                      }
                    },
                    child: Text("Save",style: TextStyle(color: Colors.white),),
                    color: Colors.deepPurpleAccent,
                    elevation: 6.0,
                  )
                ],
              ),
            ),
      ),
    );
  }

  InputDecoration textFieldBorderDecoration(String hintText) {
    return InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.deepPurpleAccent),
              ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
            );
  }
}
