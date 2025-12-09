import strutils

proc solve*():int =
  var matrix:seq[seq[string]];
  for row in readFile("./daySix/input.txt").splitLines():
    let elements = row.splitWhitespace()
    while matrix.len() < elements.len():
      matrix.add(@[])
    for col, val in elements:
      matrix[col].add(val)
  

  var ans = 0;
  
  for problem in matrix:
    var sum = 0;
    var prod = 1;
    for s in problem:
      if s=="*":
        ans += prod;
      elif s=="+":
        ans += sum;
      else:
        sum+=parseInt(s)
        prod*=parseInt(s)
  return ans;

proc solvePartTwo*():int =
  var matrix:seq[string] = readFile("./daySix/input.txt").splitLines
  
  var emptyline = "";

  while(emptyline.len() < matrix[0].len):
    emptyline.add(" ")
  
  matrix[matrix.len()-1] = emptyline
  while(matrix.len < matrix[0].len):
    matrix.add(emptyline)
  
  for i in countup(0, matrix.len()-1):
    for j in countup(i+1,matrix[0].len()-1):
      let temp = matrix[i][j]
      matrix[i][j] = matrix[j][i]
      matrix[j][i] = temp
  
  var ans =0;
  var adding= false;
  var multiplicating = false;
  var current_count = 0;
  for line in matrix:
    let elements = line.splitWhitespace()
    var i = 0;
    while(i < elements.len()):
      var curr = elements[i];
      if(curr[curr.len-1] == '+'):
        ans+=current_count;
        current_count = 0;
        adding = true;
        multiplicating = false;
        current_count = 0;
      elif(i != elements.len()-1 and elements[i+1].startsWith("+")):
        ans+=current_count;
        current_count = 0;
        adding = true;
        multiplicating = false;
        current_count = 0;
        i+=1;
      elif(curr[curr.len-1] == '*'):
        ans+=current_count;
        current_count = 0;
        multiplicating = true;
        adding = false;
        current_count = 1;
      elif(i != elements.len()-1 and elements[i+1].startsWith("*")):
        ans+=current_count;
        current_count = 0;
        multiplicating = true;
        adding = false;
        current_count = 1;
        i+=1;

      var newElement = curr;
      if(newElement[curr.len()-1] == '+' or newElement[newElement.len()-1] == '*'):
        newElement = newElement[0..newElement.len()-2]

      if(adding):
        current_count+=parseInt(newElement);
      elif(multiplicating):
        current_count*=parseInt(newElement);

      i+=1;
  return ans+current_count;
