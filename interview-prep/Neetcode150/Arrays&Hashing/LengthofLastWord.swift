class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var ans = 0
        for char in s.reversed() { 
            if char != " " { 
                ans+=1
            } else if ans > 0 { 
                return ans
            }
        }
        return ans
    }
}

/*
Time Complexity: O(N)
Space Complexity: O(1)
*/