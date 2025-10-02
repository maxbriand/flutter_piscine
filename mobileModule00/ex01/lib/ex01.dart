import 'package:flutter/material.dart';

class Ex00Page extends StatefulWidget {
  const Ex00Page({super.key});

  @override
  State<Ex00Page> createState() => _Ex00PageState();
}

class _Ex00PageState extends State<Ex00Page> {
  var _isHelloWorld = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isHelloWorld ? Text("Hello World") : Text("A Simple Text"),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isHelloWorld = !_isHelloWorld;
                  });
                  debugPrint("Button pressed $_isHelloWorld");
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
