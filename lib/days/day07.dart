import '../day.dart';

class Day07 extends Day {
  @override
  bool get completed => true;

  @override
  void init() {
    super.init();
    equations.clear();
    for (var line in inputList) {
      equations.add(Equation(line));
    }
  }

  @override
  part1() {
    var total = 0;
    for (var equation in equations) {
      if (equation.isValid(equation.factors.toList())) {
        total += equation.result;
      }
    }
    return total;
  }

  @override
  part2() {
    var total = 0;
    for (var equation in equations) {
      if (equation.isValid2(equation.factors.toList())) {
        total += equation.result;
      }
    }
    return total;
  }
}

List<Equation> equations = [];

class Equation {
  List<int> factors = [];
  int result = 0;
  Equation(String data) {
    var parts = data.split(" ");
    for (var part in parts) {
      if (part.endsWith(":")) {
        result = int.parse(part.substring(0, part.length - 1));
      } else {
        factors.add(int.parse(part));
      }
    }
  }

  bool isValid(var terms) {
    if (terms.length == 1) {
      return terms[0] == result;
    } else {
      var t0 = terms.removeAt(0);
      var t1 = terms.removeAt(0);
      var res1 = t0 + t1;
      var res2 = t0 * t1;
      var terms1 = terms.toList();
      var terms2 = terms.toList();
      terms1.insert(0, res1);
      terms2.insert(0, res2);
      return isValid(terms1) || isValid(terms2);
    }
  }

  bool isValid2(var terms) {
    if (terms.length == 1) {
      return terms[0] == result;
    } else {
      var t0 = terms.removeAt(0);
      var t1 = terms.removeAt(0);
      var res1 = t0 + t1;
      var res2 = t0 * t1;
      var res3 = int.parse(t0.toString() + t1.toString());
      var terms1 = terms.toList();
      var terms2 = terms.toList();
      var terms3 = terms.toList();
      terms1.insert(0, res1);
      terms2.insert(0, res2);
      terms3.insert(0, res3);
      return isValid2(terms1) || isValid2(terms2) || isValid2(terms3);
    }
  }
}
