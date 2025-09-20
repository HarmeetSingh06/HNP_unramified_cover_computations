from sage.interfaces.gap import gap
import sys

gap.eval('Read("unram.gap");')

d = int(sys.argv[1])
index_start = int(sys.argv[2])

# Call the GAP function
gap.eval(f'FalseUnramObstList({d}, {index_start});')