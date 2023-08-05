class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.count == 0 { 
            return 0
        }
        var maxLen = 1
        var numsSet = Set(nums)
        for num in nums { 
            if !numsSet.contains(num - 1) { 
                var len = 1
                var currNum = num+1
                while numsSet.contains(currNum) { 
                    len+=1
                    currNum+=1
                    maxLen = max(maxLen, len)
                }
            }
        }
        return maxLen
    }
}

/*
Time compleity: O(N)
Space complexity: O(N)
*/