# https://www.hackerrank.com/challenges/30-binary-trees
# Python 3

# Given
import sys

class Node:
    def __init__(self,data):
        self.right=self.left=None
        self.data = data
        
class Solution:
    def insert(self,root,data):
        if root==None:
            return Node(data)
        else:
            if data<=root.data:
                cur=self.insert(root.left,data)
                root.left=cur
            else:
                cur=self.insert(root.right,data)
                root.right=cur
        return root

    def levelOrder(self,root):
        #Write your code here
        if root is None:
            return 0

        q = []
        levels = []

        q.append(root)

        while(len(q) > 0):
            levels.append(q[0].data)
            root = q.pop(0)

            if root.left is not None:
                q.append(root.left)
            if root.right is not None:
                q.append(root.right)

        print(" ".join([str(val) for val in levels]))

# Given
T=int(input())
myTree=Solution()
root=None
for i in range(T):
    data=int(input())
    root=myTree.insert(root,data)
myTree.levelOrder(root)
