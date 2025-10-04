import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorAppPage extends StatefulWidget {
  const CalculatorAppPage({super.key});

  @override
  State<StatefulWidget> createState() => CalculatorAppPageState();
}

class CalculatorAppPageState extends State<CalculatorAppPage> {
  var _operation = "0";
  var _result = "0";
  final _keysL1 = ["7", "8", "9", "C", "AC"];
  final _keysL2 = ["4", "5", "6", "+", "-"];
  final _keysL3 = ["1", "2", "3", "x", "/"];
  final _keysL4 = ["0", ".", "00", "="];

  void _clear(String key) {
    setState(() {
      _operation = "0";
      if (key == "AC") _result = "0";
    });
  }

  void _buildOperation(String key) {
    setState(() {
      if (_operation == "0") {
        _operation = key;
      } else if (_operation.length < 16) {
        _operation += key;
      }
    });
  }

  void _calculate() {
    setState(() {
      try {
        final parser = GrammarParser();
        final result = parser.parse(_operation.replaceAll("x", "*"));
        var evaluator = RealEvaluator();
        var evaluation = evaluator.evaluate(result);
        _result = evaluation.toString();
      } catch (f) {
        debugPrint("error: $f");
        _operation = "0";
        _result = "Error";
      }
    });
  }

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
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        _result,
                        style: TextStyle(
                          color: Color(0xFF607D8B),
                          fontSize: 30,
                          letterSpacing: 2,
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
                    CalculatorRow(
                      line: _keysL1,
                      buildOperation: _buildOperation,
                      calculate: _calculate,
                      clear: _clear,
                    ),
                    CalculatorRow(
                      line: _keysL2,
                      buildOperation: _buildOperation,
                      calculate: _calculate,
                      clear: _clear,
                    ),
                    CalculatorRow(
                      line: _keysL3,
                      buildOperation: _buildOperation,
                      calculate: _calculate,
                      clear: _clear,
                    ),
                    CalculatorRow(
                      line: _keysL4,
                      buildOperation: _buildOperation,
                      calculate: _calculate,
                      clear: _clear,
                    ),
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
  final void Function(String) buildOperation;
  final void Function() calculate;
  final void Function(String) clear;

  const CalculatorRow({
    super.key,
    required this.line,
    required this.buildOperation,
    required this.calculate,
    required this.clear,
  });

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
                  switch (line[i]) {
                    case "C" || "AC":
                      clear(line[i]);
                    case "=":
                      calculate();
                    case _:
                      buildOperation(line[i]);
                  }
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
