import 'package:flutter/material.dart';

class Ex00Page extends StatefulWidget {
  const Ex00Page({super.key});

  @override
  State<Ex00Page> createState() => _Ex00PageState();
}

class _Ex00PageState extends State<Ex00Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("A Simple Text"),
              TextButton(
                onPressed: () {
                  debugPrint("Button pressed");
                },
                child: Text("Click me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
