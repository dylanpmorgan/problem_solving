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

    def getHeight(self,root):
        # Write your code here
        # Using recursion
        if root is None:
            return -1
        else:
            return max(self.getHeight(root.left),self.getHeight(root.right))+1


T=int(input())
myTree=Solution()
root=None
for i in range(T):
    data=int(input())
    root=myTree.insert(root,data)
height=myTree.getHeight(root)
print(height)

"""
Doing it iteratively
    def getHeight(self,root):
        if root is None:
            return 0

        q = []

        q.append(root)
        
        # this hackerrank problem specifies edges as number of edges as height
        # rather than number of nodes. This method counts nodes, so we'll start
        # at -1
        height = -1

        while(True):

            rootCount=len(q)
            if rootCount==0:
                return height

            height+=1

            while rootCount > 0:
                root = q[0]
                q.pop(0)

                if root.left is not None:
                    q.append(root.left)
                if root.right is not None:
                    q.append(root.right)

                rootCount -= 1
"""
