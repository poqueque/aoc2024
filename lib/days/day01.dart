import '../main.dart';

class Day01 extends Day {
  @override
  bool get completed => true;

  @override
  part1() {
    var sum = 0;
    var list1 = <int>[];
    var list2 = <int>[];
    for (var i = 0; i < inputList.length; i++) {
      var a = inputList[i].split("   ");
      list1.add(int.parse(a[0]));
      list2.add(int.parse(a[1]));
    }
    list1.sort();
    list2.sort();
    for (var i = 0; i < list1.length; i++) {
      var d = list1[i]- list2[i];
      if (d < 0) d = -d;
      sum += d;
    }
    return sum;
  }
  @override
  part2() {
    var sum = 0;
    var list1 = <int>[];
    var list2 = <int>[];
    for (var i = 0; i < inputList.length; i++) {
      var a = inputList[i].split("   ");
      list1.add(int.parse(a[0]));
      list2.add(int.parse(a[1]));
    }
    list1.sort();
    list2.sort();
    for (var i = 0; i < list1.length; i++) {
      var sim = list2.where((element) => element == list1[i]).length;
        list1[i] *= sim;
      sum += list1[i];
    }
    return sum;
  }
}
