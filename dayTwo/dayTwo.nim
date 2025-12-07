import strutils
import re

proc incrementString*(str: var string) =
  var i = str.len()-1
  while i >= 0 and str[i] == '9':
    str[i] = '0';
    i-=1
  
  if i < 0:
    str.insert("1",0);
  else:
    str[i]= char(int(str[i])+1);

proc isInvalid*(str:string):bool =
  return match(str, re"^(.*)\1+$")

proc solve*():uint = 
  let file = readFile("./dayTwo/input.txt").replace("\n", "")
  let ranges:seq[string] = file.split(",")

  var ans:uint = 0;
  for range in ranges:
    let splited = range.split('-')
    var curr = splited[0];
    var k:int = 0;
    while curr != splited[1]:
      k = k+1;
      if isInvalid(curr):
        ans+=parseUInt(curr);
      incrementString(curr)

    if isInvalid(curr):
      ans+=parseUInt(curr);

  return ans
