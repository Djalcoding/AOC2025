import strutils

proc accesible(i:int, j:int, matrix:var seq[seq[bool]]):bool =
  var count = 0;
  if(i > 0):
    if(matrix[i-1][j]):
      count+=1;
    if(j > 0 and matrix[i-1][j-1]):
      count+=1;
    if(j < matrix[0].len()-1 and matrix[i-1][j+1]):
      count+=1;
  if(i < matrix.len()-1):
    if(matrix[i+1][j]):
      count+=1;
    if(j > 0 and matrix[i+1][j-1]):
      count+=1;
    if(j < matrix[0].len()-1 and matrix[i+1][j+1]):
      count+=1;
  if(j < matrix[0].len()-1 and matrix[i][j+1]):
    count+=1;
  if(j > 0 and matrix[i][j-1]):
      count+=1;

  return count <= 3;

proc solve*():uint = 
  let file = readFile("./dayFour/test.txt").split('\n')
  var matrix:seq[seq[bool]];
  for line in file:
    if(line == ""):
      continue;
    matrix.add(newSeq[bool]())
    for c in line:
      matrix[matrix.len()-1].add(c == '@')
  
  var ans:uint = 0;
  var i:int = 0;
  var j:int = 0;
  while(i < matrix.len()-1):
    while(j < matrix[0].len()-1):
      if(accesible(i,j,matrix) and matrix[i][j]):
        matrix[i][j] = false;
        i = 0;
        j = 0;
        ans+=1;
        break;
      j+=1;
    i+=1;
  
  return ans;
