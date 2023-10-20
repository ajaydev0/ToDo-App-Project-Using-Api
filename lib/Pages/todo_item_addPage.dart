// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/Utils/snackBar_utils.dart';
import 'package:todo_app/services/todo_service.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  //Dispose Controller
  @override
  void dispose() {
    titleController;
    descriptionController;
    super.dispose();
  }

  //Controller
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      titleController.text = todo["title"];
      descriptionController.text = todo["description"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Todo" : "Add ToDo"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: isEdit ? updateData : submitData,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(isEdit ? "Update" : "Submit"),
              )),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////////////////////
  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    //Get Update data to the server
    final id = todo["_id"];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    var respose = await TodoService.updateData(id, body);
    if (respose) {
      showSnackMessage(context, message: "Update Success");
    } else {
      showSnackMessage(context,
          message: "Update Failed",
          backgroundColor: Colors.red,
          tcolor: Colors.white);
    }
  }

  Future<void> submitData() async {
    //Get the data to the server
    var respose = await TodoService.submitData(body);
    if (respose) {
      titleController.text = "";
      descriptionController.text = "";
      showSnackMessage(context, message: "Creation Success");
    } else {
      showSnackMessage(context,
          message: "Creation Failed",
          backgroundColor: Colors.red,
          tcolor: Colors.white);
    }
  }

//For body
  Map get body {
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
