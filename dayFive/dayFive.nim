import strutils

type elementRange* = object
  top:int
  bottom:int

proc newRange(line:string):ref elementRange=
    let s = line.split('-')
    result = new(elementRange)
    result.top = parseInt(s[1])
    result.bottom = parseInt(s[0]);
proc inRange(range:ref elementRange, line:string):bool =
  return parseInt(line) >= range.bottom and parseInt(line) <= range.top;
proc buildText*():seq[string] =
  return readFile("./dayFive/test.txt").split('\n')
proc overlap(start:ref elementRange, ranges:var seq[ref elementRange]): ref elementRange=
  return start


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
    let r = newRange(line);
    ranges.add(r)
  return ans;
