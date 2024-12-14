import '../day.dart';

class Day13 extends Day {
  @override
  bool get completed => true;

  List<(Equation, Equation)> equations = [];

  @override
  init() {
    super.init();
    late int a1, a2, b1, b2, c1, c2;
    for (var line in inputList) {
      var parts = RegExp(r'-?\d+')
          .allMatches(line)
          .map((match) => int.parse(match.group(0)!))
          .toList();
      if (line.startsWith("Button A:")) {
        a1 = parts[0];
        a2 = parts[1];
      }
      if (line.startsWith("Button B:")) {
        b1 = parts[0];
        b2 = parts[1];
      }
      if (line.startsWith("Prize:")) {
        c1 = parts[0];
        c2 = parts[1];
        equations.add((Equation(a1, b1, c1), Equation(a2, b2, c2)));
      }
    }
  }

  @override
  part1() {
    var total = 0;
    for (var e in equations) {
      var s = solve1(e.$1, e.$2);
      total += s.$1 * 3 + s.$2;
    }
    return total;
  }

  @override
  part2() {
    var total = 0;
    for (var e in equations) {
      e.$1.c += 10000000000000;
      e.$2.c += 10000000000000;
      Point a = (x: e.$1.a, y: e.$2.a);
      Point b = (x: e.$1.b, y: e.$2.b);
      Point c = (x: e.$1.c, y: e.$2.c);
      var s = solve2((a: a, b: b, c: c));
      total += s;
    }
    return total;
  }
}

class Equation {
  //aX + bY = c
  int a;
  int b;
  int c;
  Equation(this.a, this.b, this.c);
}

int mcd(int a, int b) {
  if (b == 0) return a;
  return mcd(b, a % b);
}

(int, int) bezout(int a, int b) {
  if (b == 0) return (1, 0);
  var (x, y) = bezout(b, a % b);
  return (y, x - (a ~/ b) * y);
}

(int, int) solve(Equation eq1, Equation eq2) {
  var x = 0;
  var y = 0;
  var d1 = mcd(eq1.a, eq1.b);
  var d2 = mcd(eq2.a, eq2.b);
  var hasSol = eq1.c % d1 == 0 && eq2.c % d2 == 0;
  print("d1: $d1, d2: $d2, hasSol: $hasSol");
  if (hasSol) {
    var (u1, v1) = bezout(eq1.a, eq1.b);
    print("u1: $u1, v1: $v1");
    var (u2, v2) = bezout(eq2.a, eq2.b);
    print("u2: $u2, v2: $v2");
  }
  return (x, y);
}

(int, int) solve1(Equation eq1, Equation eq2) {
  var x = 0;
  var y = 0;
  for (var i = 0; i < 1000; i++) {
    for (var j = 0; j < 1000; j++) {
      if (eq1.a * i + eq1.b * j == eq1.c && eq2.a * i + eq2.b * j == eq2.c) {
        x = i;
        y = j;
        break;
      }
    }
  }
  return (x, y);
}

typedef Point = ({int x, int y});

extension PointExtension on Point {
  Point operator +(var other) {
    if (other is int) return (x: x + other, y: y + other);
    if (other is Point) return (x: x + other.x, y: y + other.y);
    throw Error();
  }

  Point operator *(int other) => (x: x * other, y: y * other);
}

int solve2(({Point a, Point b, Point c}) equation) {
  final (:a, :b, :c) = equation;

  double x0 = (c.x * b.y - c.y * b.x) / (a.x * b.y - a.y * b.x);
  double x1 = (a.x * c.y - a.y * c.x) / (a.x * b.y - a.y * b.x);

  int i0 = x0.toInt(), i1 = x1.toInt();

  int result = 3 * i0 + i1;
  return a * i0 + b * i1 == c ? result : 0;
}
