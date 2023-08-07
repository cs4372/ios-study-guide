class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var array = Array(s)
        var charMap = [Character: Int]()
        var maxLen = 0
        var left = 0
        for right in 0..<array.count { 
            charMap[array[right], default: 0]+=1
            while (right-left+1)-(charMap.values.max() ?? 0) > k { 
                charMap[array[left], default: 0]-=1
                left+=1
            }
            
            maxLen = max(maxLen, right-left+1)
        }
        return maxLen
    }
}

/*
General idea: Sliding window approach. Loop through array and store count of each character 
Keep a left pointer and calculate current length by (right-start+1)
If current length - max value among the count of chars stored in charMap > k, then decrement the value of charMap[array[left]]

TC: O(N)
SC: O(N)
*/