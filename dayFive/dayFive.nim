import strutils
import algorithm

type elementRange* = object
  top:int
  bottom:int

proc newRange(line:string):ref elementRange=
    let s = line.split('-')
    result = new(elementRange)
    result.top = parseInt(s[1])
    result.bottom = parseInt(s[0]);
proc newRange(bottom:int, top:int): ref elementRange=
  result = new(elementRange)
  result.top = top;
  result.bottom = bottom;

proc invalidRange():ref elementRange=
  result = new(elementRange)
  result.top = -1;
  result.bottom = -1;

proc inRange(range:ref elementRange, line:string):bool =
  return parseInt(line) >= range.bottom and parseInt(line) <= range.top;
proc buildText*():seq[string] =
  return readFile("./dayFive/input.txt").split('\n')
proc overlaps(left:ref elementRange, right: ref elementRange):bool=
  return left.top >= right.bottom and left.bottom <= right.top
proc fuseRanges(left: ref elementRange, right: ref elementRange): ref elementRange=
  return newRange(min(left.bottom, right.bottom), max(left.top,right.top));

proc mergeOverlap(ranges:var seq[ref elementRange]): var seq[ref elementRange]=
  var match = true;
  while(match):
    match = false;
    for i in countup(0,ranges.len()-1):
      if ranges[i].top == -1:
        continue;
      for j in countup(i+1,ranges.len()-1):
        var first = ranges[i];
        var second = ranges[j];
        if second.top == -1:
          continue;
        if overlaps(first,second):
          match = true;
          ranges[i] = fuseRanges(first,second);
          ranges[j]= invalidRange()
  return ranges


proc solvePartOne*():int=
  var ans:int = 0;
  let file = buildText()
  var seperator:bool = false;
  var ranges:seq[ref elementRange] = newSeq[ref elementRange]()
  for line in file:
    if(line == ""):
      seperator = true;
      continue;
    if(not seperator):
      ranges.add(newRange(line))
    else :
      for r in ranges:
        if inRange(r,line):
          ans = ans+1;
          break;
  return ans;

proc solvePartTwo*():int =
  # unfinished
  var ans = 0;
  let file = buildText()
  var ranges:seq[ref elementRange] = newSeq[ref elementRange]()
  for line in file:
    if(line == ""):
      break;
    ranges.add(newRange(line))
  ranges =mergeOverlap(ranges)
  for range in ranges:
    if range.top != -1:
      ans = ans + range.top - range.bottom+1
    echo range.bottom, ", ", range.top
  return ans;
