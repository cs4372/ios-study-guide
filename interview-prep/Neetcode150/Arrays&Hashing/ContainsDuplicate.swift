class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
       return nums.count != Set(nums).count
    }
}

/*
Time Complexity: O(n)
Space Complexity: O(n)
*/