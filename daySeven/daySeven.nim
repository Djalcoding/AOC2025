import std/sets
import strutils
proc buildMatrix:(seq[seq[bool]],int)=
  var matrix:seq[seq[bool]];
  var s = 0;
  for line in readFile("./daySeven/input.txt").splitLines:
    matrix.add(@[])
    for i,c in line:
      if(c == 'S'):
        s = i
      matrix[matrix.len()-1].add(c == '^')
  return (matrix,s)


proc solveDayOne*():int =
  var (matrix,s) = buildMatrix();

  var set = toHashSet([s]);  
  var ans =0;
  for i in countup(1,matrix.len()-2):
    var setCopy = set;
    for j in setCopy:
      if(matrix[i][j]):
        ans+=1;
        set = set.difference(toHashSet([j]))
        set = set.union(toHashSet([j+1,j-1]));
  return ans;


type particle= object
  pos:int
  count:int

proc newParticle(pos:int, count:int):ref particle=
  result.pos = pos;
  result.count = count;

proc solveDayTwo*():int = 
  var (matrix,s)=  buildMatrix();
  var particles =[newParticle(s,1)]
