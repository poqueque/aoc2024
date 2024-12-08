import 'package:aoc2024/utils/log.dart';

import '../day.dart';
import '../utils/coor.dart';

class Day06 extends Day {
  @override
  bool get completed => true;

  late Map<Coor, String> grid;
  late int maxX, maxY;
  Set<Coor> visited = {};
  Set<(Coor, Direction)> orientedVisited = {};

  @override
  init() {
    Map<Coor, String> gridL;
    int maxXL, maxYL;
    (gridL, maxXL, maxYL) = readGrid<String>();
    grid = gridL;
    maxX = maxXL;
    maxY = maxYL;
  }

  @override
  part1() {
    return pathLength(grid);
  }

  int pathLength(Map<Coor, String> grid) {
    Coor cursor = grid.keys.firstWhere((k) => grid[k] == "^");
    Direction direction = Direction.up;
    visited.clear();
    orientedVisited.clear();
    bool looping = false;
    do {
      visited.add(cursor);
      orientedVisited.add((cursor, direction));
      var nextCursor = cursor.move(direction);
      if (grid[nextCursor] == "#") {
        direction = direction.toRight();
      } else {
        cursor = nextCursor;
        if (orientedVisited.contains((cursor, direction))) {
          looping = true;
          break;
        }
      }
    } while (grid[cursor] != null);
    return looping ? -1 : visited.length;
  }

  @override
  part2() {
    var lock = 0;
    for (int i = 0; i < maxX; i++) {
      for (int j = 0; j < maxY; j++) {
        if (grid[Coor(i, j)] == ".") {
          var grid2 = Map<Coor, String>.from(grid);
          grid2[Coor(i, j)] = "#";
          var path = pathLength(grid2);
          if (path == -1) {
            lock++;
            progressLog(lock);
          }
        }
      }
    }
    progressLog("");
    return lock;
  }
}

extension on Direction {
  Direction toRight() {
    if (this == Direction.up) return Direction.right;
    if (this == Direction.right) return Direction.down;
    if (this == Direction.down) return Direction.left;
    return Direction.up;
  }
}
