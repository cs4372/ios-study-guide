class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head

        while fast?.next != nil { 
            fast = fast?.next?.next
            slow = slow?.next
        }
        return slow
    }
}

/*
- Use slow, fast pointers
TC: O(n)
SC: O(1) 
*/