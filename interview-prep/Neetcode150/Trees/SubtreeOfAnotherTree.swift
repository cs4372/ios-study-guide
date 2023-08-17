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
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil { return false }
        return isSameTree(root, subRoot) || isSameTree(root?.left, subRoot) || isSameTree(root?.right, subRoot)
    }

    func isSameTree(_ node1: TreeNode?, _ node2: TreeNode?) -> Bool { 
        if (node1 == nil && node2 == nil) { return true }
        if (node1 == nil || node2 == nil) { return false }
        return node1?.val == node2?.val && isSameTree(node1?.left, node2?.left) && isSameTree(node1?.right, node2?.right)
    }
}

/*
TC: O(MN) - M be the number of nodes in tree, M be the number of nodes in subRoot 
SC: O(M+N) - M and N recursive calls
*/