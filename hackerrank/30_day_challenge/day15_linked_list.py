# https://www.hackerrank.com/challenges/30-linked-list

# Given
class Node:
    def __init__(self,data):
        self.data = data
        self.next = None
# Given
class Solution:
    def display(self,head):
        current = head
        while current:
            print(current.data,end=' ')
            current = current.next

    def insert(self,head,data):
    #Complete this method
        if head is None:
            head = Node(data)
        else:
            node = head
            while node.next is not None:
                node = node.next
            node.next = Node(data)
        return head

# Given
mylist= Solution()
T=int(input())
head=None
for i in range(T):
    data=int(input())
    head=mylist.insert(head,data)
mylist.display(head)
