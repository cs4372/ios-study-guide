class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var ans = Array(repeating: 1, count: nums.count)
        for i in 1 ..< nums.count { 
            ans[i] = ans[i-1] * nums[i-1]
        }
        var right = 1
        for i in (0 ..< nums.count).reversed() { 
            ans[i] *= right
            right*=nums[i]
        }
        return ans
    }
}

/*
Time compleity: O(N)
Space complexity: O(1)
*/