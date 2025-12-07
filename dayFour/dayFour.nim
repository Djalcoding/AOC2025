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
  let file = readFile("./dayFour/input.txt").split('\n')
  var matrix:seq[seq[bool]];
  for line in file:
    if(line == ""):
      continue;
    matrix.add(newSeq[bool]())
    for c in line:
      matrix[matrix.len()-1].add(c == '@')
  
  var ans:uint = 0;
  var found = true;
  while found:
    found = false
    for i in countup(0,matrix.len()-1):
      for j in countup(0,matrix[0].len()-1):
        if(matrix[i][j] and accesible(i,j,matrix)):
          matrix[i][j] = false
          found = true;
          ans+=1;
    
  
  return ans;
