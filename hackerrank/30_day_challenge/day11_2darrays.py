#!/bin/python3
#https://www.hackerrank.com/challenges/30-2d-arrays

import sys

arr = []
for arr_i in range(6):
   arr_t = [int(arr_temp) for arr_temp in input().strip().split(' ')]
   arr.append(arr_t)

xlen = len(arr)
ylen = len(arr[0])

hourglass_sums = []
# Matrix length of ylen, xlen. Hourglass can fit in that xlen-3+1 times
for j in range(ylen-2):
    for i in range(xlen-2):
        hourglass_x = arr[j][i]+arr[j][i+1]+arr[j][i+2]
        hourglass_y = arr[j+1][i+1]
        hourglass_z = arr[j+2][i]+arr[j+2][i+1]+arr[j+2][i+2]
        hourglass_sums.append(hourglass_x+hourglass_y+hourglass_z)

print(max(hourglass_sums))
