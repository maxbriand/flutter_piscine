import 'package:flutter/material.dart';

class Ex02Page extends StatefulWidget {
  const Ex02Page({super.key});

  @override
  State<StatefulWidget> createState() => Ex02PageState();
}

class Ex02PageState extends State<Ex02Page> {
  var _operation = "0";
  var _result = "0";
  final _keysL1 = ["7", "8", "9", "C", "AC"];
  final _keysL2 = ["4", "5", "6", "+", "-"];
  final _keysL3 = ["1", "2", "3", "x", "/"];
  final _keysL4 = ["0", ".", "00", "="];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF485E68),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xFF607D8B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Calculator", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xFF37474F),
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_operation), 
                    Text(_result)
                    
                  ]),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Color(0xFF607D8B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  textBaseline: TextBaseline.ideographic,
                  spacing: 10, 
                  children: [
                    CalculatorRow(line: _keysL1),
                    CalculatorRow(line: _keysL2),
                    CalculatorRow(line: _keysL3),
                    CalculatorRow(line: _keysL4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorRow extends StatelessWidget {
  final List<String> line;

  const CalculatorRow({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final button in line)
          ElevatedButton(onPressed: () {}, child: Text(button)),
      ],
    );
  }
}
