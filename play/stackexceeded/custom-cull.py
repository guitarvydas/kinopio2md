import json
import sys
import re

# file = open('full-cards-split', 'r')
# data = sys.stdin.read ()

terminator = ""
 
try:
    # for rawLine in file:
    for rawLine in sys.stdin:
        line = rawLine.strip ()
        if re.search ("{", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
        elif re.search ("}", line):
            print (line)
        # elif re.search ("\"id\":", line):
        #     print (f"{terminator}{line[:-1]}"
        elif re.search ("\"cards\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ""
        elif re.search ("\"connections\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ""
        elif re.search ("\"name\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
        elif re.search ("\"name\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
        elif re.search ("\"startCardId\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
        elif re.search ("\"startCardId\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
        elif re.search ("\"connectionTypeId\":", line):
            print (f"{terminator}{line[:-1]}")
            terminator = ","
except:
    sys.exit ("An exception occurred in cull.py (out of memory?)")

file.close()
    
