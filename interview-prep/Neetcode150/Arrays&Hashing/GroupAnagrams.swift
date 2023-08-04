class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var dict: [String:[String]] = [:]
        for str in strs { 
            var word =  String(str.sorted())
            if let _ = dict[word] { 
                dict[word]?.append(str)
            } else { 
                dict[word] = [str]
            }
        }
        return Array(dict.values)
    }
}

/*
Time compleity: Sorting takes O(Klog(K)) and looping takes O(n) so  O(nKlog(K)
Space complexity: Worst case would be n unique anagram groups so O(N)
*/