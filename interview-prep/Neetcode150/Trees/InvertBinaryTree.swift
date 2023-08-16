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
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        var queue = [root]
        while queue.count > 0 { 
            let size = queue.count
            for i in 0..<size { 
                var node = queue.removeFirst()
                var tmp = node?.right
                node?.right = node?.left
                node?.left = tmp
                if let left = node?.left {
                    queue.append(left)
                }
                if let right = node?.right { 
                    queue.append(right)
                }
            }
        }
        return root
    }
}

/*
TC: O(N) - each node in the tree is visited once
SC: O(N) - queue will contain all nodes in 1 level of the binary tree
*/