import 'package:aoc2024/utils/coor.dart';
import 'package:aoc2024/utils/extensions.dart';

import '../main.dart';

class Day04 extends Day {

  @override
  bool get completed => true;

  @override
  part1() {
    int width = inputList[0].length;
    int height = inputList.length;
    List<String> data = inputList.toList();
    for (String line in inputList) {
      data.add(line.reverse());
    }
    var inputMap = <Coor,String>{};
    for (int i = 0; i < inputList.length; i++) {
      for (int j = 0; j < inputList[i].length; j++) {
        inputMap[Coor(i,j)] = data[i][j];
      }
    }
    for (int i = 0; i < height; i++) {
      String s = "";
      for (int j = 0; j < width; j++) {
        s += inputMap[Coor(j,i)]!;
      }
      data.add(s);
      data.add(s.reverse());
    }
    for (int i = -height; i < height; i++) {
      String s = "";
      for (int j = 0; j < width; j++) {
        if (inputMap[Coor(j+i, j)] != null) s += inputMap[Coor(j+i,j)]!;
      }
      data.add(s);
      data.add(s.reverse());
    }
    for (int i = 0; i < 2 * height; i++) {
      String s = "";
      for (int j = 0; j < width; j++) {
        if (inputMap[Coor(j, i-j)] != null) s += inputMap[Coor(j,i-j)]!;
      }
      data.add(s);
      data.add(s.reverse());
    }
    var countXmas = 0;
    for (var s in data) {
      while (s.contains("XMAS")){
        countXmas++;
        s = s.replaceFirst("XMAS", "XS");
      }
    }
    return countXmas;
  }

  @override
  part2() {
    var inputMap = <Coor,String>{};
    for (int i = 0; i < inputList.length; i++) {
      for (int j = 0; j < inputList[i].length; j++) {
        inputMap[Coor(i,j)] = inputList[i][j];
      }
    }
    var countXmas = 0;
    for (var k in inputMap.keys){
      if (inputMap[k] == "A"){
        var correctMAS = 0;
        if (inputMap[k+Coor(-1,-1)] == "M" && inputMap[k+Coor(1,1)] == "S"){
          correctMAS++;
        }
        if (inputMap[k+Coor(1,-1)] == "M" && inputMap[k+Coor(-1,1)] == "S"){
          correctMAS++;
        }
        if (inputMap[k+Coor(1,1)] == "M" && inputMap[k+Coor(-1,-1)] == "S"){
          correctMAS++;
        }
        if (inputMap[k+Coor(-1,1)] == "M" && inputMap[k+Coor(1,-1)] == "S"){
          correctMAS++;
        }
        if (correctMAS >= 2) {
          countXmas++;
        }
      }
    }
    return countXmas;
  }
}
