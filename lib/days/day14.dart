import 'package:aoc2024/utils/coor.dart';

import '../day.dart';

class Day14 extends Day {
  @override
  bool get completed => false;

  List<Coor> p0 = [];
  List<Coor> v = [];

  @override
  init() {
    super.init();
    for (var line in inputList) {
      var parts = RegExp(r'-?\d+')
          .allMatches(line)
          .map((match) => int.parse(match.group(0)!))
          .toList();
      p0.add(Coor(parts[0], parts[1]));
      v.add(Coor(parts[2], parts[3]));
    }
  }

  @override
  part1() {
    var steps = 100;
    var xMod = 101;
    var yMod = 103;
    List<Coor> p1 = [];
    var q1 = 0;
    var q2 = 0;
    var q3 = 0;
    var q4 = 0;
    for (var i = 0; i < p0.length; i++) {
      var x = (p0[i].x + v[i].x * steps) % xMod;
      var y = (p0[i].y + v[i].y * steps) % yMod;
      p1.add(Coor(x, y));
      if (x < (xMod - 1) / 2 && y < (yMod - 1) / 2) {
        q1++;
      } else if (x < (xMod - 1) / 2 && y > (yMod - 1) / 2) {
        q2++;
      } else if (x > (xMod - 1) / 2 && y < (yMod - 1) / 2) {
        q3++;
      } else if (x > (xMod - 1) / 2 && y > (yMod - 1) / 2) {
        q4++;
      }
    }
    // for (var j = 0; j < yMod; j++) {
    //   var line = "";
    //   for (var k = 0; k < xMod; k++) {
    //     var c = p1.where((e) => e == Coor(k, j)).length;
    //     if (p1.contains(Coor(k, j))) {
    //       line += "$c";
    //     } else {
    //       line += ".";
    //     }
    //   }
    //   print(line);
    // }
    return q1 * q2 * q3 * q4;
  }

  @override
  part2() {
    var xMod = 101;
    var yMod = 103;
    var safetyFactor = 1000000000000000;
    var safetyFactorSteps = 0;
    for (var steps = 0; steps < 10807; steps++) {
      List<Coor> p1 = [];
      var q1 = 0;
      var q2 = 0;
      var q3 = 0;
      var q4 = 0;
      for (var i = 0; i < p0.length; i++) {
        var x = (p0[i].x + v[i].x * steps) % xMod;
        var y = (p0[i].y + v[i].y * steps) % yMod;
        p1.add(Coor(x, y));
        if (x < (xMod - 1) / 2 && y < (yMod - 1) / 2) {
          q1++;
        } else if (x < (xMod - 1) / 2 && y > (yMod - 1) / 2) {
          q2++;
        } else if (x > (xMod - 1) / 2 && y < (yMod - 1) / 2) {
          q3++;
        } else if (x > (xMod - 1) / 2 && y > (yMod - 1) / 2) {
          q4++;
        }
      }
      var s = q1 * q2 * q3 * q4;
      if (s < safetyFactor) {
        safetyFactor = s;
        safetyFactorSteps = steps;
        if (safetyFactorSteps == 7753) {
          for (var j = 0; j < yMod; j++) {
            var line = "";
            for (var k = 0; k < xMod; k++) {
              var c = p1.where((e) => e == Coor(k, j)).length;
              if (p1.contains(Coor(k, j))) {
                line += "$c";
              } else {
                line += ".";
              }
            }
            print(line);
          }
        }
      }
    }
    return safetyFactorSteps;
  }
}
