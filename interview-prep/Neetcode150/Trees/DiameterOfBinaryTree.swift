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
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var diameter = 0
        func traverse(_ node: TreeNode?) -> Int { 
            guard let node = node else { return 0 }
            let left = traverse(node.left)
            let right = traverse(node.right)
            diameter = max(diameter, left + right)
            return max(left, right) + 1
        }
        traverse(root)
        return diameter
    }
}

/*
TC: O(N)
SC: O(N)
*/