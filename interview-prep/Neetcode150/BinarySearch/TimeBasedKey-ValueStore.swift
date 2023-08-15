
class TimeMap {

    var timeDict: [String: [(String, Int)]]

    init() {
        self.timeDict = [:]
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        timeDict[key, default:[]].append((value, timestamp))
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        guard let vals = timeDict[key] else {
            return ""
        }
        var count = timeDict[key]!.count
        var low = 0
        var high = count-1
        var res = ""
        while low <= high { 
            var mid = (low+high)/2
            if vals[mid].1 <= timestamp { 
                res = vals[mid].0
                low = mid + 1
            } else { 
                high = mid-1
            }
        }
        return res
    }
}

/**
 * Your TimeMap object will be instantiated and called as such:
 * let obj = TimeMap()
 * obj.set(key, value, timestamp)
 * let ret_2: String = obj.get(key, timestamp)
 */

 /*
- Set function => Use a dictionary to store key and value and timestamp as tuples
Time complexity for set: O(1), append it to dictionary key
- Get function => Get the values of the given key in dictionary as use Binary search to check 
if timestamp in dictionary <= timestamp

Time complexity: O(logn) - n be the number of values in the given key in dictionary
Space complexity: O(m * n) - m be the number of keys and n be the timestamp-values pairs
 */