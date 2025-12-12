import strutils
import std/deques
import std/sets

proc buildTestcase(str:string):(int, seq[int]) =
  var target = 0;
  var buttons:seq[int];
  var currentButton = 0;
  var targetLen = 0;
  for c in str:
    case c:
      of '#':
        target = target shl 1;
        target+=1
        targetLen+=1;
      of '.':
        target = target shl 1;
        targetLen+=1;
      of ')':
        buttons.add(currentButton)
        currentButton = 0
      of '{':
        break
      else:
        if c.isDigit():
          currentButton = currentButton or (1 shl abs((((int)c) - (int) '0') - targetLen+1))
        continue
  
  return (target, buttons)

proc findMinimumAmoutOfFlips(target:int, buttons:var seq[int]):int =
  var queue:Deque[int] = initDeque[int]();
  var seen:HashSet[int] = initHashSet[int]();
  queue.addFirst(0)
   
  var count = 0;
  while queue.len > 0:
    var size = queue.len();
    while size > 0:
      size-=1;
      let front = queue.peekLast();
      queue.popLast();
      if seen.contains(front):
        continue
      seen.incl(front)
      
      if(front == target):
        return count

      for button in buttons:
        queue.addFirst(front xor button)


    count+=1
  return -1


proc solve*():int =
  var ans = 0;
  for line in readFile("./dayTen/test.txt").splitLines:
    var (s,b) = buildTestcase(line)
    ans += findMinimumAmoutOfFlips(s,b);
  return ans 

