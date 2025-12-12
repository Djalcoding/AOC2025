import strutils
import std/tables
import std/sets

proc dfs(pos:string, map:var Table[string,seq[string]], seen: var Table[(string,bool,bool), int], sawDAC:bool, sawFFT:bool):int = 
  if(pos == "out"):
    if((not sawDAC) or (not sawFFT)):
      return 0;
    return 1
  
  if(seen.contains((pos,sawDAC,sawFFT))):
    return seen[(pos,sawDAC,sawFFT)]

  var ans = 0;
  for connection in map[pos]:
    ans += dfs(connection,map,seen,(sawDAC or pos == "dac"),(sawFFT or pos == "fft"))
  seen[(pos,sawDAC,sawFFT)] = ans;
  return ans


proc solve*():int =
  var ans = 0;
  var map:Table[string,seq[string]];
  let lines = readFile("./dayEleven/input.txt").splitLines();
  for line in lines:
    if line == "":
      continue
    let startPoint = line[0..2]
    let rightPart = line[4..line.len()-1]
    map[startPoint] = @[];
    for path in rightPart.splitWhitespace():
      map[startPoint].add(path)

  var seen:Table[(string,bool,bool),int];
  return dfs("svr", map,seen,false,false)
