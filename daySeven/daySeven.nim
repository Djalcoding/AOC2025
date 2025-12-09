import std/sets
import strutils
proc buildMatrix:(seq[seq[int]],int)=
  var matrix:seq[seq[int]];
  var s = 0;
  for line in readFile("./daySeven/input.txt").splitLines:
    matrix.add(@[])
    for i,c in line:
      if(c == 'S'):
        s = i
      if(c == '^'):
        matrix[matrix.len()-1].add(-1)
      else:
        matrix[matrix.len()-1].add(0)
  return (matrix,s)


proc solveDayOne*():int =
  var (matrix,s) = buildMatrix();

  var set = toHashSet([s]);  
  var ans =0;
  for i in countup(1,matrix.len()-2):
    var setCopy = set;
    for j in setCopy:
      if(matrix[i][j] == -1):
        ans+=1;
        set = set.difference(toHashSet([j]))
        set = set.union(toHashSet([j+1,j-1]));
  return ans;

proc dfs*(i:int,j:int,matrix:var seq[seq[int]]): int=
  if (i >= matrix.len()-1):
    return 1;
  if(matrix[i][j] == -1):
    let val:int = dfs(i+1,j+1,matrix) + dfs(i+1,j-1,matrix)
    matrix[i][j]=val;
    return val;
  elif matrix[i][j] != 0:
    return matrix[i][j];
  return dfs(i+1,j,matrix);

proc solveDayTwo*():int = 
  var (matrix,s)=  buildMatrix();
  return dfs(0,s, matrix);





