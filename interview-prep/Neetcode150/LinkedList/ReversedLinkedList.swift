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
    func reverseList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode?
        var curr = head
        while curr != nil { 
            var currNext = curr?.next
            curr?.next = prev
            prev = curr
            curr = currNext
        }
        return prev
    }
}

/*
Time Complexity: O(n) - n be the list's length
Space Complexity: O(1)
*/