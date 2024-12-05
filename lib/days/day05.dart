
import '../main.dart';

class Day05 extends Day {

  @override
  bool get completed => false;

  List<(int,int)> orderRules = [];
  List<List<int>> reports = [];

  @override
  init() {
    for (var line in inputList) {
      if (line.contains("|")){
        orderRules.add((int.parse(line.split("|")[0]), int.parse(line.split("|")[1])));
      } else if (line.contains(",")){
        reports.add(line.split(",").map((e) => int.parse(e)).toList());
      }
    }
  }


  @override
  part1() {
    var sum = 0;
    for (var report in reports) {
      if (isValid(report)) {
        sum += getMiddle(report);
      }
    }
    return sum;
  }

  @override
  part2() {
    var sum = 0;
    for (var report in reports) {
      if (!isValid(report)) {
        while(!isValid(report)) {
          report = order(report);
        }
        sum += getMiddle(report);
      }
    }
    return sum;
  }

  bool isValid(List<int> report) {
    for (var rule in orderRules) {
      var pos1 = report.indexOf(rule.$1);
      var pos2 = report.indexOf(rule.$2);
      if (pos1 > -1 && pos2 > -1) {
        if (pos1 > pos2) {
          return false;
        }
      }
    }
    return true;
  }

  int getMiddle(List<int> report) {
    return report[report.length ~/ 2];
  }

  List<int> order(List<int> report) {
    for (var rule in orderRules) {
      var pos1 = report.indexOf(rule.$1);
      var pos2 = report.indexOf(rule.$2);
      if (pos1 > -1 && pos2 > -1) {
        if (pos1 > pos2) {
          var temp = report[pos1];
          report[pos1] = report[pos2];
          report[pos2] = temp;
        }
      }
    }
    return report;
  }
}
