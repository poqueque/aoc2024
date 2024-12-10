import 'package:aoc2024/utils/log.dart';

import '../day.dart';

class Day09 extends Day {
  @override
  bool get completed => true;

  late List<int?> disk;
  late List<Block> blockDisk;

  @override
  init() {
    disk = [];
    bool block = true;
    for (var i = 0; i < inputList[0].length; i++) {
      int c = int.parse(inputList[0][i]);
      if (block) {
        for (var j = 0; j < c; j++) {
          disk.add(i ~/ 2);
        }
      } else {
        for (var j = 0; j < c; j++) {
          disk.add(null);
        }
      }
      block = !block;
    }
    //print(disk);
  }

  @override
  part1() {
    while (disk.contains(null)) {
      var firstNull = disk.indexOf(null);
      if (disk.last == null) {
        disk.removeAt(disk.length - 1);
      } else {
        disk[firstNull] = disk.removeAt(disk.length - 1);
      }
    }
//    print(disk);
    return checkSum(disk);
  }

  init2() {
    blockDisk = [];
    bool block = true;
    for (var i = 0; i < inputList[0].length; i++) {
      int c = int.parse(inputList[0][i]);
      if (block) {
        blockDisk.add(Block(i ~/ 2, c));
      } else {
        blockDisk.add(Block(-1, c));
      }
      block = !block;
    }
  }

  @override
  part2() {
    init2();
    var lastId = inputList[0].length ~/ 2;
    for (int i = lastId; i > 0; i--) {
      var blockIndex = blockDisk.indexWhere((element) => element.id == i);
      var block = blockDisk[blockIndex];
      if (block.size == 0) {
        blockDisk.remove(block);
        continue;
      }
      var fitBlock = blockDisk.indexWhere(
          (element) => element.id == -1 && element.size >= block.size);
      if (fitBlock > -1 && fitBlock < blockIndex) {
        blockDisk[fitBlock].size -= block.size;
        blockDisk.insert(fitBlock, Block(block.id, block.size));
        block.id = -1;
      }
      blockDisk.removeWhere((element) => element.size == 0);
      for (var j = 0; j < blockDisk.length - 1; j++) {
        if (blockDisk[j].id == -1 && blockDisk[j + 1].id == -1) {
          blockDisk[j].size += blockDisk[j + 1].size;
          blockDisk.removeAt(j + 1);
        }
      }
      progressLog(i);
    }
    progressLog("");
    return checkSum2(blockDisk);
  }

  int checkSum(List<int?> disk) {
    int cs = 0;
    for (var i = 0; i < disk.length; i++) {
      cs += i * disk[i]!;
    }
    return cs;
  }

  int checkSum2(List<Block> blockDisk) {
    int cs = 0;
    int cursor = 0;
    for (var block in blockDisk) {
      for (var i = 0; i < block.size; i++) {
        if (block.id > -1) {
          cs += cursor * block.id;
        }
        cursor++;
      }
    }
    return cs;
  }
}

class Block {
  int size;
  int id;
  Block(this.id, this.size);
  @override
  toString() {
    return "[$id, $size]";
  }
}
