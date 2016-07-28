#https://www.hackerrank.com/challenges/30-inheritance

# Given
class Person:
	def __init__(self, firstName, lastName, idNumber):
		self.firstName = firstName
		self.lastName = lastName
		self.idNumber = idNumber
	def printPerson(self):
		print("Name:", self.lastName + ",", self.firstName)
		print("ID:", self.idNumber)

class Student(Person):
    def __init__(self, firstName, lastName, idNumber, scores):
        super(Student, self).__init__(firstName, lastName, idNumber)
        self.scores = scores

    def calculate(self):
        medianGrade = sum(self.scores)/len(self.scores)

        if (medianGrade >= 90) and (medianGrade <= 100):
            return "O"
        elif (medianGrade >= 80) and (medianGrade < 90):
            return "E"
        elif (medianGrade >= 70) and (medianGrade < 80):
            return "A"
        elif (medianGrade >= 55) and (medianGrade < 70):
            return "P"
        elif (medianGrade >= 40) and (medianGrade < 55):
            return "D"
        else:
            return "T"

# Given
line = input().split()
firstName = line[0]
lastName = line[1]
idNum = line[2]
numScores = int(input()) # not needed for Python
scores = list( map(int, input().split()) )
s = Student(firstName, lastName, idNum, scores)
s.printPerson()
print("Grade:", s.calculate())
