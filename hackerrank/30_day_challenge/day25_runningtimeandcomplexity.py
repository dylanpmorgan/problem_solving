#https://www.hackerrank.com/challenges/30-running-time-and-complexity

N = int(input())

for x in range(N):
    num = int(input())
    if num==1:
        print("Not prime")
        continue

    isPrime = any([1 if num%x == 0 else 0 for x in range(2, int(num**0.5)+1)])
    if isPrime==True:
        print("Not prime")
    else:
        print("Prime")
