class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var low = s.startIndex
        var high = s.index(before: s.endIndex)

        while low < high { 
            if !s[low].isNumber, !s[low].isLetter { 
                low = s.index(after: low)
                continue
            }
            if !s[high].isNumber, !s[high].isLetter { 
                high = s.index(before: high)
                continue
            }
            if s[low].lowercased() != s[high].lowercased() { 
                return false
            }
            low = s.index(after: low)
            high = s.index(before: high)
         }
         return true
    }
}

/*
TC: O(N)
SC: O(1)
*/