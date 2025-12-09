import strutils
import std/tables
import std/math
import std/sets

proc buildList():seq[seq[int]]=
  let lines = readFile("./dayEight/test.txt").splitLines
  var list:seq[seq[int]];

  for line in lines:
    if line == "":
      continue
    list.add(@[])
    for num in line.split(','):
      list[list.len()-1].add(parseInt(num))

  return list

proc distance(one: seq[int] , two:seq[int]):float =
  let x = (float)one[0]-two[0];
  let y = (float)one[1]-two[1];
  let z = (float)one[2]-two[2];
  return sqrt(pow(x,2)+ pow(y,2) + pow(z,2));
proc solveDayOne*():int =
  var list = buildList()
  var map:TableRef[int,HashSet[int]]

  for i in countup(0,list.len()-1):
    var minimumDistance:float = 2147483647;
    var closest = 0;
    for j in countup(0, list.len()-1):
      if(i == j):
        continue;
      let cube = list[i]
      let secondCube = list[j]
      let currentDistance = distance(cube,secondCube);
      if(currentDistance < minimumDistance):
        minimumDistance = currentDistance
        closest = j
  return 0;

