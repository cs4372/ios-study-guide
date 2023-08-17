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
    func isBalanced(_ root: TreeNode?) -> Bool {
        return helper(root) != -1
    }

    func helper(_ node: TreeNode?) -> Int { 
        guard let node = node else { return 0 }
        let leftDepth = helper(node.left)
        let rightDepth = helper(node.right)
        if abs(leftDepth-rightDepth) > 1 || leftDepth == -1 || rightDepth == -1 { 
            return -1
        }
        return max(leftDepth, rightDepth) + 1
    }
}

/*
**** A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.
TC: O(N)
SC: O(N)
*/