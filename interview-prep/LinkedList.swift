public class Node<T> { 
    var value: T
    var next: Node<T>?
    var previous: Node<T>?

    init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> { 
    var head: Node<T>?
    private var tail: Node<T>?

    public var isEmpty: Bool { 
        return head == nil
    }

    public var first: Node<T>? { 
        return head
    }

    public var last: Node<T>? { 
        return tail
    }

    public func appendEnd(value: T) { 
        let newNode = Node(value: value)

        if let tailNode = tail { 
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    public func appendFront(value: T) { 
        let newNode = Node(value: value)

        if let headNode = head { 
            newNode.next = headNode
         } else {
             head = newNode
         }
         head = newNode
    }

    public func appendAtIndex(value: T, indexAt: Int) {
        let newNode = Node(value: value)
        if indexAt == 0 { 
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = self.getNodeAtIndex(index: indexAt-1)
            let nextNode = prev!.next
            newNode.previous = prev
            newNode.next = prev!.next

            prev!.next = newNode
            nextNode?.previous = newNode 
        }
    }

    func removeElements(_ head: Node?, _ val: Int) -> Node? {
        if head == nil { return nil }
        var curr = head
        while curr!.next != nil { 
            if curr!.next!.val == val { 
                curr!.next = curr!.next!.next
            } else { 
                curr = curr!.next
            }
        }
        return head!.val == val ? head!.next : head!
    }

    public func getCount() -> Int { 
        var currCount = 0
        var curr = head
        while curr != nil { 
            currCount+=1
            curr = curr!.next
        }
        return currCount
    }

    public func getNodeAtIndex(index: Int) -> Node<T>? {
        var node: Node<T>?
        var currNode = head
        if index == 0 {
            node = head
        } else { 
            var currNode = currNode?.next
            for idx in 1..<index { 
                currNode = currNode?.next
                node = currNode
                if currNode == nil { 
                    break
                } 
            }
        }
        return node
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var curr = head
        while curr != nil { 
            text += "\(curr!.value)"
            curr = curr!.next
            if curr != nil { 
                text += ", "
            }
        }
        return text + "]"
    }
}

let ll = LinkedList<Int>()