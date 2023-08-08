class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        let sumWithMissingNum = nums.reduce(0, +)
        var totalSum = nums.count * (nums.count+1)/2
        return totalSum - sumWithMissingNum
    }
}

/*
Time Complexity: O(N)
Space Complexity: O(1)
*/