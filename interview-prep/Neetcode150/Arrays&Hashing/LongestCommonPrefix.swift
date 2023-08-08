class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        var prefix = strs[0]
        for str in strs { 
            while !str.hasPrefix(prefix) { 
                prefix.removeLast()
                if prefix == "" { return "" }
            }
        }
        return prefix
    }
}

/*
General idea: Set prefix to the first word of the array. Iterate the array and while current word does not 
have the prefix of prefix, keep removing the last character.

TC: O(N*M) - O(N) iterations as we loop through the array and M is the length of the shortest string
SC: O(1)
*/