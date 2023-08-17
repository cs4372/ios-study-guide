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
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var prev: TreeNode?
        var res = Int.max

        func helper(_ node: TreeNode?) {
            if let currNode = node { 
                helper(currNode.left)
                if let prevNode = prev { 
                    res = min(res, currNode.val-prevNode.val)
                }
                prev = currNode
                helper(currNode.right)
            }
        }
        helper(root)
        return res
    }
}

/*
TC: O(N)
SC: O(N)
*/