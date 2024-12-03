import 'dart:math';

import '../main.dart';

class Day03 extends Day {
  @override
  bool get completed => false;

  @override
  part1() {
    var total = 0;
    var t = 0;
    for (var element in inputList) {
      var lastPartRE = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
      var parts = lastPartRE.allMatches(element);
      for (var part in parts) {
        var data = part.group(0) ?? "";
        var first = int.parse(data.substring(4, data.indexOf(",")));
        var second = int.parse(data.substring(data.indexOf(",") + 1, data.length - 1));
        total += first * second;
        t++;
      }
    }
    // print("Total: $total");
    // print("Count: $t");
    return total.toString();
  }

  @override
  part2() {
    var total = 0;
    var t = 0;
    var doRE = RegExp(r"do\(\)");
    var dontRE = RegExp(r"don't\(\)");
    var mulRE = RegExp(r"mul\(\d{1,3},\d{1,3}\)");
    var valid = true;
    for (var element in inputList) {
      var line = element;
      late int a;
      late int b;
      late int c;
      var max = 10000000000000;
      do {
         a = doRE.firstMatch(line)?.start ?? max;
         b = dontRE.firstMatch(line)?.start ?? max;
         var mul = mulRE.firstMatch(line);
         c = mulRE.firstMatch(line)?.start ?? max;
         if (a == max && b == max && c == max) {
           break;
         }
         if (a<b && a<c) {
           valid = true;
         } else if (b<a && b<c) {
           valid = false;
         } else if (valid) {
               var data = mul!.group(0) ?? "";
               var first = int.parse(data.substring(4, data.indexOf(",")));
               var second = int.parse(data.substring(data.indexOf(",") + 1, data.length - 1));
               total += first * second;
               t++;
         }
         line = line.substring(min(min(a,b),c) + 1);
      } while (a <max || b < max || c < max);
    }
    // print("Total: $total");
    // print("Count: $t");
    return total.toString();
  }
}
