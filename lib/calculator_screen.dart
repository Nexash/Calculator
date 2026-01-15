import 'package:calculator/calculate_logic.dart';
import 'package:calculator/clickable_container.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController controller = CalculatorController();
  final List<String> calculatorElements = [
    "C",
    "up",
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
    "up": const Color.fromARGB(186, 225, 215, 215),
    "%": const Color.fromARGB(186, 225, 215, 215),
  };
  final List<String> calculatorElementslast = ["0", ".", "="];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.isResultShow ? controller.expression : "",
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 176, 169, 169),
                      ),
                    ),
                    Text(
                      controller.fullExpression,
                      style: TextStyle(fontSize: 60, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
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
                    MediaQuery.of(context).size.width / 2 - 15, // double width
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
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
