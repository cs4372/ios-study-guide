class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var low = 0
        var high = numbers.count - 1

        while low <= high { 
            var sum = numbers[low] + numbers[high]
            if target == sum { 
                return [low+1,high+1]
            }
            if sum > target { 
                high-=1
            } else if sum < target { 
                low+=1
            } else {
                low+=1
                high-=1
            }
        }
        return [-1,-1]
    }
}

/*
TC: O(N)
SC: O(1)
*/