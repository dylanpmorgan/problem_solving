# https://www.hackerrank.com/challenges/30-scope

# Given
class Difference:
    def __init__(self, a):
        self.__elements = a

    # Add your code here
    def computeDifference(self):
        diff = [abs(e0-e1) for i, e0 in enumerate(self.__elements[:-1])
                for e1 in self.__elements[i+1:]]

        self.maximumDifference = max(diff)

# Given
# End of Difference class
_ = input()
a = [int(e) for e in input().split(' ')]

d = Difference(a)
d.computeDifference()

print(d.maximumDifference)
