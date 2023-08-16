/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var currLevel = [root]
        var nextLevel = [TreeNode]()

        while !currLevel.isEmpty {
            nextLevel = []

            for node in currLevel { 
                if let leftChild = node.left {
                    nextLevel.append(leftChild)
                }
                if let rightChild = node.right { 
                    nextLevel.append(rightChild)
                }
            }

            if nextLevel.isEmpty { 
                return currLevel.reduce(0) { $0 + $1.val }
            } 
            currLevel = nextLevel
        }
        return 0
    }
}

/*
- Use BFS to iterate over each row / level in the tree 
- Have 2 queues: currlevel to store all the nodes in the corresponding row and next Level 
- If next level is empty, then we have reached the last deepest level, so we can calculate all the values in that row

TC: O(N) be the number of nodes
SC: O(N)
*/