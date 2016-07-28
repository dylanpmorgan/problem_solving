#Write your code here
class Calculator(object):
    def __init__(self):
        self.error = None

    def power(self, n, p):
        if (n >= 0) and (p >= 0):
            return n**p
        else:
            self.error = "n and p should be non-negative"
            return self.error

# Given
myCalculator=Calculator()
T=int(input())
for i in range(T):
    n,p = map(int, input().split())
    try:
        ans=myCalculator.power(n,p)
        print(ans)
    except Exception as e:
        print(e) 
