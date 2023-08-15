/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var resList = ListNode(-1)
        var currNode: ListNode? = resList
        var node1 = list1
        var node2 = list2

        while let curr1 = node1, let curr2 = node2 {
            if curr1.val < curr2.val { 
                currNode?.next = curr1
                node1 = curr1.next
            } else {
                currNode?.next = curr2
                node2 = curr2.next
            }
            currNode = currNode?.next
        }
        currNode?.next = node1 ?? node2
        return resList.next
    }
}

/*
TC: O(n+m) - n be the length of list1 and m be the length of list2
SC: O(1)
*/