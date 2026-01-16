class CalculatorController {
  String _input = "";
  double _firstNumber = 0;
  bool _isResultShown = false;
  String _expression = "";
  String _output = "";
  String oper = "";

  // getters for UI to access
  String get input => _input;
  bool get isResultShow => _isResultShown;
  String get expression => _expression;

  String get output => _output;

  String get fullExpression {
    if (_output == "Error") return "Error";

    // If result is shown, return the final output
    if (_isResultShown) return _output;

    // Otherwise, just show what the user typed
    return _expression + _input;
  }

  void press(String button) {
    switch (button) {
      case "C":
        _input = "";
        _expression = "";
        _output = "";
        oper = "";
        _isResultShown = false;
        break;

      case "=":
        _calculate();
        _isResultShown = true;
        break;
      case "-":
        if (_input.isEmpty) {
          if (_isResultShown) {
            // Start new operation from result
            _handleOperator(button);
            _isResultShown = false;
            return;
          } else if (oper.isNotEmpty) {
            // Already an operator, user wants negative number
            _input = "-";
            return;
          } else {
            // Nothing typed yet, user wants negative number
            _input = "-";
            return;
          }
        } else {
          // Regular subtraction operator
          _handleOperator(button);
        }
        break;

      case "+":
      case "÷":
      case "×":
      case "%":
        if (_input.isEmpty && oper.isEmpty) return;
        _handleOperator(button);
        break;

      default:
        if (_isResultShown) {
          _input = "";
          _isResultShown = false;
        }
        _input += button;
    }
  }

  void _handleOperator(String operator) {
    if (_input.isNotEmpty) {
      // Append current number and operator to expression for UI
      _expression += _input + operator;

      // Calculate running total if previous operator exists
      if (_firstNumber != 0 && oper.isNotEmpty) {
        _calculate(fromEquals: false); // updates _firstNumber
      } else {
        _firstNumber = double.parse(_input); // store first number
      }

      _input = ""; // ready for next input
    } else if (_isResultShown && _output.isNotEmpty) {
      // If result is shown, continue calculation from previous output
      _expression = _output + operator;
      _firstNumber = double.parse(_output);
      _input = "";
    } else {
      // User pressed operator with no input, just update operator
      _expression += operator;
    }

    oper = operator;
    _isResultShown = false;

    // Optional: you can comment this out if you don't want running total shown
    // _output = _format(_firstNumber);
  }

  String _format(double value) {
    // Limit to 4 decimal places
    String text = value.toStringAsFixed(4);

    // Remove trailing zeros
    if (text.contains('.')) text = text.replaceAll(RegExp(r'\.?0+$'), '');

    // Use exponential if too long

    if (text.length > 12) {
      text = value.toStringAsExponential(6); // 6 decimals in exponent
    }

    return text;
  }

  void _calculate({bool fromEquals = true}) {
    String result = "";
    if (oper.isEmpty) return;

    if (_input.isEmpty) {
      if (oper == "%") {
        _firstNumber = _firstNumber * 0.01;
        _output = _format(_firstNumber);
        if (fromEquals) _isResultShown = true;
        return;
      } else {
        _output = _format(_firstNumber);
        if (fromEquals) _isResultShown = true;
        return;
      }
    }

    double secondNumber = double.parse(_input);

    if (oper == "÷" && secondNumber == 0) {
      _output = "Error";
      _isResultShown = true;
      return;
    }

    switch (oper) {
      case "+":
        _firstNumber += secondNumber;
        break;
      case "-":
        _firstNumber -= secondNumber;
        break;
      case "×":
        _firstNumber *= secondNumber;
        break;
      case "÷":
        _firstNumber /= secondNumber;
        break;
      case "%":
        _firstNumber %= secondNumber;
        break;
    }

    result = _format(_firstNumber);
    if (fromEquals) {
      _isResultShown = true;
      _expression += _input;
      _output = result;
    }

    _input = "";
  }
}
