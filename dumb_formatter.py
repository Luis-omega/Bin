#!/usr/bin/env python3

def make_indentation(level:int):
    return level*"  "

def format(s:str):
  indent_level = 0
  for c in s :
    match c :
      case " ":
        if indent_level>0:
          yield "\n"
          yield make_indentation(indent_level)
        else:
          yield " "
      case "\n":
        yield "\n"
        if indent_level>0:
          yield make_indentation(indent_level)
      case "("|"{"|"[":
        indent_level+=1
        yield c
        yield "\n"
        if indent_level>0:
            yield  make_indentation(indent_level)
      case ")"|"}"|"]":
        indent_level-=1
        in_bracket = True
        yield "\n"
        if indent_level>0:
            yield make_indentation(indent_level)
        yield c
      case _ :
        yield c


def main():
  input = sys.stdin.read()
  for item in format(input):
    print(item,sep="",end="")

if __name__=="__main__":
  import sys
  main()
