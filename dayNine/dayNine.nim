import strutils

type point = object
  x:int
  y:int

proc area(a:point, b:point):int =
  return (abs(a.x - b.x)+1) * (abs(a.y - b.y)+1)

proc buildList:seq[point] =
  var ans:seq[point] = @[]
  for line in readFile("./dayNine/input.txt").splitLines():
    if(line == ""):
      continue;
    let parsed = line.split(',')
    ans.add(point(x:parseInt(parsed[0]), y:parseInt(parsed[1])))
  return ans 

proc solve*():int = 
  let list = buildList()
  var maxArea = 0;
  for i in countup(0,list.len()-1):
    for j in countup(i+1, list.len()-1):
      maxArea = max(area(list[i], list[j]), maxArea)
  return maxArea;
