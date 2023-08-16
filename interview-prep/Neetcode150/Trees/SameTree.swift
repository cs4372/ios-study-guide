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
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
       if (p == nil && q == nil) { return true }
       if (p == nil || q == nil) { return false }
       if (p?.val != q?.val) { return false }
       return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
}

/*
TC: O(N) -> Each node is visited once in the tree
SC: O(N) - recursion stack
*/