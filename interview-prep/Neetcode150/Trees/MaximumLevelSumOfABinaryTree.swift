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
    func maxLevelSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxSum = Int.min
        var level = 1
        var maxLevel = 1
        var queue = [root]
        while queue.count > 0 { 
            var currSum = 0
            let size = queue.count
            for i in 0..<size { 
                let node = queue.removeFirst()
                currSum+=node.val
                if let leftNode = node.left { 
                    queue.append(leftNode)
                }
                if let rightNode = node.right { 
                    queue.append(rightNode)
                }
            }
            if currSum > maxSum {
                maxSum = currSum
                maxLevel = level
            }
            level+=1
        }
        return maxLevel
    }
}

/*
TC: O(N)
SC: O(N)
*/