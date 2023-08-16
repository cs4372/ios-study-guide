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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else { return [] }
        var res = [[Int]]()
        var queue = [root]

        while queue.count > 0 { 
            var innerArr = [Int]()
            let size = queue.count
            for i in 0..<size { 
                var node = queue.removeFirst()
                innerArr.append(node.val)
                if let left = node.left { 
                    queue.append(left)
                }
                if let right = node.right { 
                    queue.append(right)
                }
            }
            res.append(innerArr)
        }
        return res
    }
}

/*
TC: O(N) be the number of nodes
SC: O(N)
*/