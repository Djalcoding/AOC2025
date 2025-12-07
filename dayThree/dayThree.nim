import strutils

proc charAsNum(c:char):uint =
  return ((uint)c)-(uint)'0';

proc buildMaximum(str:string, i:int, sum:ref int, count:int,minValue:var seq[int]):int =
  if(i >= str.len() or str.len() - i < 12-count or count >= 12 or minValue[count]>sum[]):
    if(count != 12):
      return 0;
    return sum[];
  
  minValue[count] = sum[];
  let dontAdd = buildMaximum(str,i+1,sum,count, minValue);
  sum[] = sum[]*10 + (int)charAsNum(str[i]);
  let doAdd = buildMaximum(str,i+1,sum,count+1,minValue);
  sum[] = (int)((sum[] - (int)charAsNum(str[i]))/10);
  return max(dontAdd,doAdd);

proc solve*():int =
  let file = readFile("./dayThree/input.txt").split('\n')
  var ans:int = 0;
  for line in file:
    var s= newSeq[int](20)
    var value = buildMaximum(line,0,int.new(),0,s);
    ans= ans + value;
  return ans


