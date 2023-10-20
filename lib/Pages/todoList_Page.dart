// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:todo_app/Utils/snackBar_utils.dart';
import 'package:todo_app/Pages/todo_item_addPage.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/widgets/todo_card.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  void initState() {
    todoListData();
    super.initState();
  }

  bool isLoading = true;
  List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List Page"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: navigateToAddPage,
          label: const Text(
            "Add Todo",
            style: TextStyle(color: Colors.white),
          )),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: todoListData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: const Center(
              child: Text(
                "No Items Here",
                style: TextStyle(fontSize: 27),
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item["_id"] as String;
                return TodoCard(
                  index: index,
                  item: item,
                  navigateToEditPage: navigateToEditPage,
                  deleteById: deleteById,
                  id: id,
                );
              },
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
////////////////////////////////////////////////////////////////////

  //Get Todo List Data
  Future<void> todoListData() async {
    var response = await TodoService.todoListData();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showSnackMessage(context,
          message: "Something Went Worng",
          backgroundColor: Colors.red,
          tcolor: Colors.white);
    }
    setState(() {
      isLoading = false;
    });
  }

  // Delete Todo Items Using Id
  Future<void> deleteById(String id) async {
    final response = await TodoService.deleteById(id);

    if (response) {
      final filter = items.where((element) => element["_id"] != id).toList();
      setState(() {
        items = filter;
      });
    } else {
      showSnackMessage(context,
          message: "Deleting Failded",
          backgroundColor: Colors.red,
          tcolor: Colors.white);
    }
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    todoListData();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    todoListData();
  }
}
