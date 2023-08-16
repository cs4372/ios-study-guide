 /*
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
    func reorderList(_ head: ListNode?) {
        if head == nil { return }
        
        var fast = head
        var slow = head
        while fast?.next != nil { 
            slow = slow?.next
            fast = fast?.next?.next
        }
        var secondList = reverseList(slow)
        mergeLists(head, secondList)
    }

    private func reverseList(_ head: ListNode?) -> ListNode? { 
        var prev: ListNode?
        var curr = head
        while curr != nil { 
            var nextNode = curr?.next
            curr?.next = prev
            prev = curr
            curr = nextNode
        }
        return prev
    }

       private func mergeLists(_ first: ListNode?, _ second: ListNode?) {
        var first = first
        var second = second
        var tmp: ListNode? = nil

        while second?.next != nil {
            tmp = first?.next
            first?.next = second
            first = tmp

            tmp = second?.next
            second?.next = first
            second = tmp
        }
    }
}

/*
General idea: 
1. Find middle node in linked list (use slow, fast pointers) -> TC: O(N)
2. Reverse second half of the linked list -> TC: O(N/2)
3. Merge both lists -> TC: O(N/2)

TC: O(N)
SC: O(1)
*/