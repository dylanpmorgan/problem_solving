#https://www.hackerrank.com/challenges/30-regex-patterns

import sys

N = int(input().strip())

names = []
for a0 in range(N):
    firstName,emailID = input().strip().split(' ')
    firstName,emailID = [str(firstName),str(emailID)]

    if "@gmail" in emailID:
        names.append(firstName)

names.sort()
for name in names: print(name)
