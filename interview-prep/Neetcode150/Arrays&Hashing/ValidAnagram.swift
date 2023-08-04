class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
           if s.count != t.count {
            return false
        }
        
        var dictS = [Character: Int]()
        var dictT = [Character: Int]()
        
        for char in s {
            dictS[char, default: 0] += 1
        }
        
        for char in t {
            dictT[char, default: 0] += 1
        }
        
        return dictS == dictT
    }
}

/*
Time Complexity: O(N)
Space Complexity: O(N)
*/