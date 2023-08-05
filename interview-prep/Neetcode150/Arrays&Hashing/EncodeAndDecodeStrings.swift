class Codec {
    /*
    Encode: For each string, append length of str + "#" + str  
    e.g. 5#Hello5#World

    Decode: Loop through the string, and while char is not "#" get the count of each string
    and append the string in a res array

    5#Hello5#World
    1. Get length => 5
    2. Get string after # (from j+1 to word count)
    3. set i to end
    */
    func encode(_ strs: [String]) -> String {
        var encodedString = ""
        for str in strs { 
            encodedString += String(str.count) + "#" + str
        }
        return encodedString
    }
    
   func decode(_ s: String) -> [String] {
    var res = [String]()
    var i = s.startIndex
    
    while i < s.endIndex {
        var j = i
        while s[j] != "#" {
            j = s.index(after: j)
        }
        
        let length = Int(s[i..<j])!
        let start = s.index(after: j)
        let end = s.index(start, offsetBy: length)
        res.append(String(s[start..<end]))
        i = end
    }
    
    return res
   }
}

/*
TC: O(N)
SC: O(N)
*/

/**
 * Your Codec object will be instantiated and called as such:
 * let obj = Codec()
 * val s = obj.encode(strs)
 * let ans = obj.decode(s)
*/