import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  void calculateResult() {
    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(calc);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        res = eval.toString();
      });
    } catch (e) {
      setState(() {
        res = 'Error';
      });
    }
  }

  String calc = '';
  
  String res = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text("Calculator"), backgroundColor: Colors.grey),
        body: Column(
          children: [
            Row(children: [Text(calc,style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold),textAlign: TextAlign.right,)]),
            Row(children:[ SizedBox(height:10)]),
            Row(children: [Text(res)]),
            Row(children:[ SizedBox(height:50)]),
            Row(
              spacing:3,
              children: [
               
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        calc = '';
                        res = '';
                      });
                    },
                    label: Icon(Icons.clear),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '(';
                      });
                    },
                    child: Text('('),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += (')');
                      });
                    },
                    child: Text(')'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('MOD'),
                  ),
                ),
              ],
            ),
            Row(children:[ SizedBox(height:10)]),
            Row(
              spacing:3,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += ('7');
                      });
                    },
                    child: Text('7'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '8';
                      });
                    },
                    child: Text('8'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '9';
                      });
                    },
                    child: Text('9'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '/';
                      });
                    },
                    child: Text('/'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += 'sqrt(';
                      });
                    },
                    child: Text('sr('),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '+';
                      });
                    },
                    child: Text('+'),
                  ),
                ),
              ],
            ),
            Row(children:[ SizedBox(height:10)]),
            Row(
              spacing:3,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '4';
                      });
                    },
                    child: Text('4'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '5';
                      });
                    },
                    child: Text('5'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '6';
                      });
                    },
                    child: Text('6'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '*';
                      });
                    },
                    child: Text('*'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '^2';
                      });
                    },
                    child: Text('^2', style: TextStyle(fontSize: 10)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '%';
                      });
                    },
                    child: Text('%'),
                  ),
                ),
              ],
            ),
            Row(children:[ SizedBox(height:10)]),
            Row(
              spacing:3,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '1';
                      });
                    },
                    child: Text('1'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '2';
                      });
                    },
                    child: Text('2'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '3';
                      });
                    },
                    child: Text('3'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '-';
                      });
                    },
                    child: Text('-'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calc += '.';
                      });
                    },
                    child: Text('.'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculateResult();
                    },
                    child: Text('='),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
