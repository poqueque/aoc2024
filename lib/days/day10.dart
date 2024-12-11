import '../day.dart';
import '../utils/coor.dart';

class Day10 extends Day {
  @override
  bool get completed => false;

  late Map<Coor, int> grid;
  late int maxX, maxY;
  Map<String, List<Coor>> antennas = {};
  Set<Coor> antinodes = {};

  @override
  init() {
    var (gridL, maxXL, maxYL) = readGrid<int>();
    grid = gridL;
    maxX = maxXL;
    maxY = maxYL;
  }

  @override
  part1() {
    List<Coor> zeros = [];
    for (var coor in grid.keys) {
      if (grid[coor] == 0) {
        zeros.add(coor);
      }
    }
    var total = 0;
    for (var zero in zeros) {
      Set<Coor> cursors = {zero};
      for (var i = 1; i <= 9; i++) {
        Set<Coor> newCursors = {};
        for (var cursor in cursors) {
          if (grid[cursor.move(Direction.up)] == i) {
            newCursors.add(cursor.move(Direction.up));
          }
          if (grid[cursor.move(Direction.down)] == i) {
            newCursors.add(cursor.move(Direction.down));
          }
          if (grid[cursor.move(Direction.left)] == i) {
            newCursors.add(cursor.move(Direction.left));
          }
          if (grid[cursor.move(Direction.right)] == i) {
            newCursors.add(cursor.move(Direction.right));
          }
          cursors = newCursors;
        }
      }
      total += cursors.length;
    }
    return total;
  }

  @override
  part2() {
    List<Coor> zeros = [];
    for (var coor in grid.keys) {
      if (grid[coor] == 0) {
        zeros.add(coor);
      }
    }
    var total = 0;
    for (var zero in zeros) {
      List<Coor> cursors = [zero];
      for (var i = 1; i <= 9; i++) {
        List<Coor> newCursors = [];
        for (var cursor in cursors) {
          if (grid[cursor.move(Direction.up)] == i) {
            newCursors.add(cursor.move(Direction.up));
          }
          if (grid[cursor.move(Direction.down)] == i) {
            newCursors.add(cursor.move(Direction.down));
          }
          if (grid[cursor.move(Direction.left)] == i) {
            newCursors.add(cursor.move(Direction.left));
          }
          if (grid[cursor.move(Direction.right)] == i) {
            newCursors.add(cursor.move(Direction.right));
          }
          cursors = newCursors;
        }
      }
      total += cursors.length;
    }
    return total;
  }
}
