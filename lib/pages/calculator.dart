import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String calc = '';
  String res = '';

  void calculateResult() {
    if (calc.isEmpty) return;
    
    try {
      // Replace % with /100 for percentage calculations
      String expression = calc.replaceAll('%', '/100');
      
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        // Format result: remove trailing zeros for whole numbers
        if (eval == eval.truncateToDouble()) {
          res = eval.toInt().toString();
        } else {
          res = eval.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      });
    } catch (e) {
      setState(() {
        res = 'Error';
      });
    }
  }

  void appendToCalc(String value) {
    setState(() {
      calc += value;
    });
  }

  void clear() {
    setState(() {
      calc = '';
      res = '';
    });
  }

  void backspace() {
    if (calc.isNotEmpty) {
      setState(() {
        calc = calc.substring(0, calc.length - 1);
      });
    }
  }

  Widget buildButton({
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.white,
            foregroundColor: textColor ?? Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: icon != null
              ? Icon(icon, size: 24)
              : Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const operatorColor = Color(0xFF4CAF50);
    const operatorTextColor = Colors.white;
    const numberColor = Colors.white;
    const specialColor = Color(0xFFE57373);
    const specialTextColor = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Display Area
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      calc.isEmpty ? '0' : calc,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      res.isEmpty ? '' : '= $res',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Button Area
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Row 1: Clear, Backspace, (, ), /
                  Expanded(
                    child: Row(
                      children: [
                        buildButton(
                          label: 'C',
                          onPressed: clear,
                          backgroundColor: specialColor,
                          textColor: specialTextColor,
                        ),
                        buildButton(
                          label: '⌫',
                          onPressed: backspace,
                          backgroundColor: specialColor,
                          textColor: specialTextColor,
                          icon: Icons.backspace_outlined,
                        ),
                        buildButton(
                          label: '(',
                          onPressed: () => appendToCalc('('),
                          backgroundColor: Colors.grey[300],
                        ),
                        buildButton(
                          label: ')',
                          onPressed: () => appendToCalc(')'),
                          backgroundColor: Colors.grey[300],
                        ),
                        buildButton(
                          label: '÷',
                          onPressed: () => appendToCalc('/'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Row 2: 7, 8, 9, *, sqrt
                  Expanded(
                    child: Row(
                      children: [
                        buildButton(
                          label: '7',
                          onPressed: () => appendToCalc('7'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '8',
                          onPressed: () => appendToCalc('8'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '9',
                          onPressed: () => appendToCalc('9'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '×',
                          onPressed: () => appendToCalc('*'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                        buildButton(
                          label: '√',
                          onPressed: () => appendToCalc('sqrt('),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Row 3: 4, 5, 6, -, ^2
                  Expanded(
                    child: Row(
                      children: [
                        buildButton(
                          label: '4',
                          onPressed: () => appendToCalc('4'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '5',
                          onPressed: () => appendToCalc('5'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '6',
                          onPressed: () => appendToCalc('6'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '−',
                          onPressed: () => appendToCalc('-'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                        buildButton(
                          label: 'x²',
                          onPressed: () => appendToCalc('^2'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Row 4: 1, 2, 3, +, %
                  Expanded(
                    child: Row(
                      children: [
                        buildButton(
                          label: '1',
                          onPressed: () => appendToCalc('1'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '2',
                          onPressed: () => appendToCalc('2'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '3',
                          onPressed: () => appendToCalc('3'),
                          backgroundColor: numberColor,
                        ),
                        buildButton(
                          label: '+',
                          onPressed: () => appendToCalc('+'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                        buildButton(
                          label: '%',
                          onPressed: () => appendToCalc('%'),
                          backgroundColor: operatorColor,
                          textColor: operatorTextColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Row 5: 0, ., =
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () => appendToCalc('0'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: numberColor,
                                foregroundColor: Colors.black87,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        buildButton(
                          label: '.',
                          onPressed: () => appendToCalc('.'),
                          backgroundColor: numberColor,
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: calculateResult,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                '=',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
