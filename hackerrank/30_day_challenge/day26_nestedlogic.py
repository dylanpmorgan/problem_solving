# https://www.hackerrank.com/challenges/30-nested-logic

returnDate = [int(val) for val in input().split( )]
dueDate = [int(val) for val in input().split( )]

diffYear = returnDate[2]-dueDate[2]
diffMth = returnDate[1]-dueDate[1]
diffDay = returnDate[0]-dueDate[0]

# A year early
if (diffYear < 0):
    print(0)
# Same year, Not late
elif (diffYear == 0) and (diffMth <= 0) and (diffDay <= 0):
    print(0)
# Days late
elif (diffYear <=0) and (diffMth <= 0) and (diffDay > 0):
    print(diffDay*15)
# Months late
elif (diffYear <=0) and (diffMth > 0):
    print(diffMth*500)
# Years late
else:
    print(10000)
