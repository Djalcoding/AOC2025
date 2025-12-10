import strutils
import std/tables
import std/math
import std/sets
import std/heapqueue
import algorithm

proc buildList():seq[seq[int]]=
  let lines = readFile("./dayEight/input.txt").splitLines
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

proc dfs(i:int,seen:var HashSet[int], map:var Table[int,HashSet[int]]):int =
  if(seen.contains(i)):
    return 0;
  seen.incl(i);
  
  var sum = 1;
  for node in map[i]:
    sum += dfs(node,seen,map);
  return sum;

type wire= object
  distance:float
  cube1:int
  cube2:int

proc `<`(a:wire, b:wire):bool = a.distance < b.distance

proc newWire(list:var seq[seq[int]], first:int, second:int):wire=
  result.cube1 = first;
  result.cube2 = second;
  result.distance =distance(list[first],list[second])

proc buildPriorityQueue(list:var seq[seq[int]]):HeapQueue[wire] =
  var queue = initHeapQueue[wire]()
  for i in countup(0,list.len()-1):
    for j in countup(i+1,list.len()-1):
      queue.push(newWire(list, i,j))
  return queue


proc solveDayOne*():int =
  var list = buildList()
  var map:Table[int,HashSet[int]] = initTable[int,HashSet[int]]() 
  var queue = buildPriorityQueue(list)

  for i in countup(1,1000):
    let front = queue[0];
    if(not map.contains(front.cube1)):
      map[front.cube1]= initHashSet[int]()
    if(not map.contains(front.cube2)):
      map[front.cube2]= initHashSet[int]()

    map[queue[0].cube1].incl(front.cube2)
    map[queue[0].cube2].incl(front.cube1)
    discard queue.pop() 
  var seen:HashSet[int] = initHashSet[int]()
  var elements:seq[int] = @[];
  for node in map.keys:
    if(seen.contains(node)):
      continue
    var d = dfs(node,seen,map);
    elements.add(d)
  elements.sort()
  return elements[elements.len()-1] * elements[elements.len()-2] * elements[elements.len()-3];



