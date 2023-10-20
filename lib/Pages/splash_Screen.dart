import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'todoList_Page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const ToDoListPage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 150,
          width: 200,
          child: Icon(
            Icons.edit_square,
            size: 130,
          ),
        ),
        SizedBox(
            height: 30,
            width: 30,
            child: FittedBox(child: CupertinoActivityIndicator())),
      ])),
    );
  }
}
