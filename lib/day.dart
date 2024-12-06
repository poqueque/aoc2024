import 'dart:io';

import 'package:aoc2024/extensions/extensions.dart';
import 'package:aoc2024/utils/coor.dart';

abstract class Day {
  late final List<String> inputList;
  late final String inputString;
  bool completed = false;

  void init() {}

  dynamic part1();

  dynamic part2();

  String get dataFileName => "${runtimeType.toString().toLowerCase()}.txt";

  void main() async {
    inputList = await File("data/$dataFileName").readAsLines();
    inputString = inputList[0];
    init();
    print(part1());
    print(part2());
  }

  Future<void> run1() async {
    inputList = await File("data/$dataFileName").readAsLines();
    inputString = inputList[0];
    init();
    print(part1());
  }

  Future<void> run2() async {
    inputList = await File("data/$dataFileName").readAsLines();
    inputString = inputList[0];
    init();
    print(part2());
  }

  (Map<Coor, T>, int, int) readGrid<T>() {
    Map<Coor, T> grid = {};
    int maxY = inputList.length;
    int maxX = inputList[0].length;
    for (int j = 0; j < maxY; j++) {
      String line = inputList[j];
      for (int i = 0; i < maxX; i++) {
        if (T == int) {
          grid[Coor(i, j)] = int.parse(line[i]) as T;
        } else if (T == String) {
          grid[Coor(i, j)] = line.chars[i] as T;
        } else {
          print("Type ${T.runtimeType.toString()} not supported");
          throw Exception("Type ${T.runtimeType} not supported");
        }
      }
    }
    return (grid, maxX, maxY);
  }
}
