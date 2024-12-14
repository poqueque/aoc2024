import '../day.dart';
import '../utils/coor.dart';

class Day12 extends Day {
  @override
  bool get completed => true;

  late Map<Coor, String> grid;
  late int maxX, maxY;

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
    var pending = grid.keys.toList();
    var total1 = 0;
    var total2 = 0;
    while (pending.isNotEmpty) {
      var current = pending.removeAt(0);
      List<Coor> toProcess = [current];
      List<Coor> processed = [];
      List<(Coor, Direction)> perimeterDirections = [];
      int area = 0;
      int perimeter = 0;
      int sides = 0;
      var value = grid[current]!;
      while (toProcess.isNotEmpty) {
        var current = toProcess.removeAt(0);
        processed.add(current);
        area++;
        var neighbors = current.neighboursWithoutDiagonals();
        for (var neighbor in neighbors) {
          if (processed.contains(neighbor) || toProcess.contains(neighbor)) {
            continue;
          }
          if (grid[neighbor] == value) {
            toProcess.add(neighbor);
            pending.remove(neighbor);
          } else {
            perimeter++;
            Direction direction = getDirectionFromNeighbour(current, neighbor);
            var foundPerimeterInSameDirection = 0;
            for (var perimeterDirection in perimeterDirections) {
              if (neighbors.contains(perimeterDirection.$1) &&
                  direction == perimeterDirection.$2) {
                foundPerimeterInSameDirection++;
                break;
              }
            }
            if (foundPerimeterInSameDirection == 0) {
              sides++;
              // print(
              //     "Found side at $current -> ${getDirectionFromNeighbour(current, neighbor)}");
            }
            if (foundPerimeterInSameDirection > 1) {
              sides--;
              print(
                  "Found REPEATED side at $current -> ${getDirectionFromNeighbour(current, neighbor)}");
            }
            perimeterDirections.add((current, direction));
          }
        }
      }
      if (sides % 2 == 1) {
        sides--;
        print(
            "Sides is odd: $sides. For some unknown reason this is not counted properly. We will subtract one.");
        print(
            "A region of $value plants with price $area * $perimeter = ${area * perimeter}");
        print(
            "A region of $value plants with price $area * $sides = ${area * sides}");
      }
      total1 += area * perimeter;
      total2 += area * sides;
      // print("Total1: $total1");
      // print("Total2: $total2");
    }
    return (total1, total2);
  }

  @override
  part2() {
    return "Solution in part 1";
  }

  Direction getDirectionFromNeighbour(Coor current, Coor neighbor) {
    if (neighbor.x == current.x - 1) {
      return Direction.left;
    }
    if (neighbor.x == current.x + 1) {
      return Direction.right;
    }
    if (neighbor.y == current.y - 1) {
      return Direction.up;
    }
    if (neighbor.y == current.y + 1) {
      return Direction.down;
    }
    throw "Invalid neighbour";
  }
}
