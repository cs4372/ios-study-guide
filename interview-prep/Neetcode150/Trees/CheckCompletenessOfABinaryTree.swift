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
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        var queue = [root]
        var nilSeen = false
        while queue.count > 0 { 
            let size = queue.count
            for i in 0..<size { 
                var node = queue.removeFirst()
                if node == nil { 
                    nilSeen = true
                    continue
                }
                if nilSeen { return false }
                queue.append(node?.left)
                queue.append(node?.right)
            }
        }
        return true
    }
}

/*
TC: O(N)
SC: O(N)
*/