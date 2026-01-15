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
    String first = _format(_firstNumber);
    if (_isResultShown) return first;
    if (oper.isEmpty) {
      return _input.isEmpty ? "" : _input;
    }
    _expression = "$first$oper$_input";
    return _input.isEmpty ? "$first$oper" : "$first$oper$_input";
  }

  void press(String button) {
    switch (button) {
      case "C":
        _input = "";

        _output = "";
        oper = "";
        _isResultShown = false;
        break;

      case "=":
        _caluclate();
        _isResultShown = true;
        break;
      case "-":
        if (_input.isEmpty) {
          if (_isResultShown) {
            // If result is shown, start a new subtraction operation
            oper = button; // set "-" as operator
            _isResultShown = false;
            _input = "";
          } else if (oper.isNotEmpty) {
            // If there’s already an operator, treat "-" as negative sign
            _input = "-";
            return;
          } else {
            // Nothing entered yet, user wants negative number
            _input = "-";
            return;
          }
        } else {
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
    if (_input.isEmpty) {
      // If user clicks operator right after result is shown
      // we use previous output as first number
      if (_isResultShown && _output.isNotEmpty) {
        _firstNumber = double.parse(_output);
      } else {
        _firstNumber = 0;
      }
    } else {
      _firstNumber = double.parse(_input);
    }

    oper = operator;

    _input = "";
    // Result shown flag is false now
    _isResultShown = false;

    // Optional: update output so UI shows "5-" for example
    _output = _format(_firstNumber);
  }

  String _format(double value) {
    // Limit to 4 decimal places
    String text = value.toStringAsFixed(4);

    // Remove trailing zeros
    text = text.replaceAll(RegExp(r'\.?0+$'), '');

    return text;
  }

  void _caluclate() {
    if (oper.isEmpty) return;
    double secondNumber;

    if (_input.isEmpty) {
      if (oper == "%") {
        _output = _format(_firstNumber * 0.01); // 5% = 0.05
        _firstNumber = _firstNumber * 0.01;
        _input = "";
        _isResultShown = true;
        return;
      } else {
        _output = _format(_firstNumber); // other operators
        _input = "";
        _isResultShown = true;
        return;
      }
    } else {
      double? secondNumberr = double.tryParse(_input);
      // if (secondNumberr == null) {
      //   _output = "Error";
      //   _isResultShown = true;
      //   return;
      // }

      // 3️⃣ Division by zero check
      if (oper == "÷" && secondNumberr == 0) {
        _output = "Error";
        _isResultShown = true;
        return;
      } else {
        secondNumber = double.parse(_input);
      }
    }

    switch (oper) {
      case "+":
        _output = _format(_firstNumber + secondNumber).toString();
        break;

      case "-":
        _output = _format(_firstNumber - secondNumber).toString();
        break;
      case "%":
        _output = _format(_firstNumber % secondNumber).toString();
        break;
      case "×":
        _output =
            (secondNumber == 0)
                ? "Error"
                : _format(_firstNumber * secondNumber).toString();
        break;
      case "÷":
        if (secondNumber == 0) {
          _output = "Error";
          _isResultShown = true;
          return; // stop execution here
        } else {
          _output = _format(_firstNumber / secondNumber);
        }
        break;
    }
    if (_output != "Error") {
      _firstNumber = double.parse(_output);
    }

    _input = "";
    _isResultShown = true;
  }
}
