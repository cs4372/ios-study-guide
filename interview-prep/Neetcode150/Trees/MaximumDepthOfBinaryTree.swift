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
    func maxDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var currLevel = 1
        var maxLevel = 1
        var queue = [root]
        while queue.count > 0 { 
            let size = queue.count
            for i in 0..<size { 
                var node = queue.removeFirst()
                if let left = node.left { 
                    queue.append(left)
                }
                if let right = node.right { 
                    queue.append(right)
                }
            }
            maxLevel = max(maxLevel, currLevel)
            currLevel+=1
        }
        return maxLevel
    }
}

/*
TC: O(N) - each node in the tree is visited once
SC: O(N) - queue will contain all nodes in 1 level of the binary tree
*/