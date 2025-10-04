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
                    Text(
                      "Calculator",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Color(0xFF37474F),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _operation,
                        style: TextStyle(
                          color: Color(0xFF607D8B),
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        _result,
                        style: TextStyle(
                          color: Color(0xFF607D8B),
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Color(0xFF607D8B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    final bool firstIsSeven = line[0] == "7";

    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < line.length; i++)
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  debugPrint("button pressed: ${line[i]}");
                },
                child: Text(
                  line[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: switch (i) {
                      0 || 1 || 2 => Color(0xFF37474F),
                      3 || 4 when firstIsSeven => Colors.red,
                      _ => Colors.white,
                    },
                    fontSize: 17,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
