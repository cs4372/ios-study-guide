class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxLen = 0
        var freqMap = [Character: Int]()
        var start = 0
        for (i, char) in s.enumerated() {
            if let currIdx = freqMap[char] {
                start = max(start, currIdx + 1)
            }
            freqMap[char] = i
            maxLen = max(maxLen, i - start + 1)
        }

        return maxLen
    }
}

/*

E.g. 
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.

a: 0
b: 1
c: 2
a is in map, then set start to currIdx + 1
...

TC: O(N)
SC: O(N)
/*