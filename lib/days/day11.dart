import '../day.dart';

class Day11 extends Day {
  @override
  bool get completed => true;

  List<int> stones = [];
  Map<(int, int), int> cache = {};

  @override
  init() {
    super.init();
    stones = inputString.split(" ").map(int.parse).toList();
  }

  @override
  part1() {
    for (var i = 0; i < 25; i++) {
      blink();
    }
    return stones.length;
  }

  @override
  part2() {
    var total = 0;
    for (var stone in stones) {
      total += blinkRecurse(75, stone);
    }
    return total;
  }

  blink() {
    List<int> newStones = [];
    for (var stone in stones) {
      var l = stone.toString().length;
      if (stone == 0) {
        newStones.add(1);
      } else if (l % 2 == 0) {
        newStones.add(int.parse(stone.toString().substring(0, l ~/ 2)));
        newStones.add(int.parse(stone.toString().substring(l ~/ 2)));
      } else {
        newStones.add(stone * 2024);
      }
    }
    stones = newStones;
  }

  int blinkRecurse(int i, int stone) {
    if (i == 0) return 1;
    if (cache[(i, stone)] != null) return cache[(i, stone)]!;

    var l = stone.toString().length;
    if (stone == 0) {
      cache[(i, stone)] = blinkRecurse(i - 1, 1);
      return cache[(i, stone)]!;
    } else if (l % 2 == 0) {
      cache[(i, stone)] = blinkRecurse(
              i - 1, int.parse(stone.toString().substring(0, l ~/ 2))) +
          blinkRecurse(i - 1, int.parse(stone.toString().substring(l ~/ 2)));
      return cache[(i, stone)]!;
    } else {
      cache[(i, stone)] = blinkRecurse(i - 1, stone * 2024);
      return cache[(i, stone)]!;
    }
  }
}
