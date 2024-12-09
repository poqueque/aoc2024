import 'package:aoc2024/utils/coor.dart';

import '../day.dart';

class Day08 extends Day {
  @override
  bool get completed => true;

  late Map<Coor, String> grid;
  late int maxX, maxY;
  Map<String, List<Coor>> antennas = {};
  Set<Coor> antinodes = {};

  @override
  init() {
    Map<Coor, String> gridL;
    int maxXL, maxYL;
    (gridL, maxXL, maxYL) = readGrid<String>();
    grid = gridL;
    maxX = maxXL;
    maxY = maxYL;
    for (int i = 0; i < maxX; i++) {
      for (int j = 0; j < maxY; j++) {
        if (grid[Coor(i, j)] != ".") {
          String antenna = grid[Coor(i, j)]!;
          if (!antennas.containsKey(antenna)) antennas[antenna] = [];
          antennas[antenna]!.add(Coor(i, j));
        }
      }
    }
  }

  @override
  part1() {
    List<String> antennaKeys = antennas.keys.toList();
    for (int i = 0; i < antennaKeys.length; i++) {
      getAntinodes(antennaKeys[i]);
    }
    return antinodes.length;
  }

  @override
  part2() {
    List<String> antennaKeys = antennas.keys.toList();
    for (int i = 0; i < antennaKeys.length; i++) {
      getAntinodesWithHarmonics(antennaKeys[i]);
    }
    return antinodes.length;
  }

  void getAntinodes(String antennaKey) {
    List<Coor> antennaList = antennas[antennaKey]!;
    for (int i = 0; i < antennaList.length; i++) {
      for (int j = i + 1; j < antennaList.length; j++) {
        Coor a = antennaList[i];
        Coor b = antennaList[j];
        var antinode1 = Coor(a.x + 2 * (b.x - a.x), a.y + 2 * (b.y - a.y));
        var antinode2 = Coor(b.x + 2 * (a.x - b.x), b.y + 2 * (a.y - b.y));
        if (!antinode1.outOfBounds(maxX, maxY)) antinodes.add(antinode1);
        if (!antinode2.outOfBounds(maxX, maxY)) antinodes.add(antinode2);
      }
    }
  }

  void getAntinodesWithHarmonics(String antennaKey) {
    List<Coor> antennaList = antennas[antennaKey]!;
    for (int i = 0; i < antennaList.length; i++) {
      for (int j = i + 1; j < antennaList.length; j++) {
        Coor a = antennaList[i];
        Coor b = antennaList[j];
        late Coor antinode1;
        int step = 0;
        do {
          antinode1 = Coor(a.x + step * (b.x - a.x), a.y + step * (b.y - a.y));
          if (!antinode1.outOfBounds(maxX, maxY)) antinodes.add(antinode1);
          step++;
        } while (!antinode1.outOfBounds(maxX, maxY));
        late Coor antinode2;
        step = 0;
        do {
          antinode2 = Coor(b.x + step * (a.x - b.x), b.y + step * (a.y - b.y));
          if (!antinode2.outOfBounds(maxX, maxY)) antinodes.add(antinode2);
          step++;
        } while (!antinode2.outOfBounds(maxX, maxY));
      }
    }
  }
}
