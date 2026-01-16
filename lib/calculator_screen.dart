import 'package:calculator/calculate_logic.dart';
import 'package:calculator/clickable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController controller = CalculatorController();
  final List<String> calculatorElements = [
    "C",
    "⌫",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
  ];
  final Map<String, Color> buttonColors = {
    "C": const Color.fromARGB(186, 225, 215, 215),
    "÷": Colors.orange,
    "×": Colors.orange,
    "-": Colors.orange,
    "+": Colors.orange,
    "=": Colors.orange,
    "⌫": const Color.fromARGB(186, 225, 215, 215),
    "%": const Color.fromARGB(186, 225, 215, 215),
  };
  final List<String> calculatorElementslast = ["0", ".", "="];

  double _getDisplayFontSize(String text) {
    final int length = text.length;

    if (length <= 16) return 60;
    if (length <= 50) return 45;
    if (length <= 50) return 35;
    if (length <= 60) return 34;
    if (length <= 70) return 28;
    return 22;
  }

  void _handleKeyPress(String key) {
    setState(() {
      switch (key) {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
        case '.':
          controller.press(key);
          break;

        case '+':
        case '-':
        case '*':
        case '/':
        // case '=':
        //   String op = key;
        //   if (op == '*') op = '×';
        //   if (op == '/') op = '÷';
        //   if (op == '+') op = '+';
        //   if (op == '%') op = '%';
        //   if (op == '=') op = '=';
        //   controller.press(op);
        //   break;

        case 'Enter':
        case '=':
          break;

        case 'Backspace':
          controller.press('⌫'); // delete button
          break;

        case '%':
          controller.press('%');
          break;

        case 'c':
        case 'C':
          controller.press('C');
          break;

        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(), // make it focused
      autofocus: true, // auto-focus so it listens immediately
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          // only on key down
          _handleKeyPress(event.logicalKey.keyLabel);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true, // 👈 important: scroll up like calculator
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.isResultShow ? controller.expression : "",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 176, 169, 169),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          controller.fullExpression,
                          style: TextStyle(
                            fontSize: _getDisplayFontSize(
                              controller.fullExpression,
                            ),
                            color: Colors.white,
                          ),

                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 12, right: 12, left: 12),
              children: [
                for (String item in calculatorElements)
                  CustomClickableContainer(
                    color: buttonColors[item],
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    ontap:
                        () => setState(() {
                          controller.press(item);
                        }),
                  ),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,

              children: [
                // First button spans 2 columns
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / 2 -
                      18, // double width
                  height: 89,
                  child: CustomClickableContainer(
                    child: Row(
                      children: [
                        SizedBox(width: 40),
                        Text(
                          "0",
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                      ],
                    ),
                    ontap:
                        () => setState(() {
                          controller.press("0");
                        }),
                  ),
                ),

                // Next two buttons
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4 - 15,
                  height: 89,
                  child: CustomClickableContainer(
                    child: Center(
                      child: Text(
                        ".",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    ontap:
                        () => setState(() {
                          controller.press(".");
                        }),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4 - 15,
                  height: 89,
                  child: CustomClickableContainer(
                    color: Colors.orange,
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    ontap:
                        () => setState(() {
                          controller.press("=");
                        }),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
