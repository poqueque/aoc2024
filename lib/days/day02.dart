import '../day.dart';

class Day02 extends Day {
  @override
  bool get completed => true;

  @override
  part1() {
    var safeReports = 0;
    for (var report in inputList) {
      var levels = report.split(" ").map((e) => int.parse(e)).toList();
      var safe = isSafe(levels);
      if (safe) {
        safeReports++;
      }
      if (!safe) {
        var levelDump = [];
        for (var i = 0; i < levels.length; i++) {
          var levelDumpNew = List<int>.from(levels);
          levelDumpNew.removeAt(i);
          levelDump.add(levelDumpNew);
        }
        for (var i = 0; i < levelDump.length; i++) {
          if (isSafe(levelDump[i])) {
            safeReports++;
            break;
          }
        }
      }
    }
    return safeReports;
  }

  @override
  part2() {
    return "0";
  }

  isSafe(List<int> levels) {
    if (levels.length == 1) return true;
    var isIncreasing = levels[1] > levels[0];
    for (var i = 1; i < levels.length; i++) {
      if (levels[i] == levels[i - 1]) {
        return false;
      }
      if (levels[i] > levels[i - 1] + 3) {
        return false;
      }
      if (levels[i] < levels[i - 1] - 3) {
        return false;
      }
      if (i > 1 && levels[i] < levels[i - 1] && isIncreasing) {
        return false;
      }
      if (i > 1 && levels[i] > levels[i - 1] && !isIncreasing) {
        return false;
      }
    }
    return true;
  }
}
