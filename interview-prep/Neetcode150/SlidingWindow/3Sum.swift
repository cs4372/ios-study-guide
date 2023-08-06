class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        var sortedNums = nums.sorted()
        for (idx, num) in sortedNums.enumerated() {
            if idx > 0 && num == sortedNums[idx-1] {
                continue
            }
            var low = idx + 1
            var high = nums.count - 1

            while low < high { 
                let currSum = sortedNums[low] + sortedNums[high] + sortedNums[idx]
                if currSum < 0 { 
                    low += 1
                } else if currSum > 0 { 
                    high -= 1
                } else { 
                    res.append([num, sortedNums[low], sortedNums[high]])
                    low+=1
                    high-=1
                    while low < high && sortedNums[low-1] == sortedNums[low] { 
                        low+=1
                    }
                    while low < high && sortedNums[high] == sortedNums[high+1] { 
                        high-=1
                    }
                }
            }
        }
        return res
    }
}

/*
General idea: Sort the array and have 3 pointers (current, low, high). Decrement/increment depending 
on if the sum of pointers is < 0 or > 0.
- Make sure prev and curr value are not equal  

TC: O(N^2)
SC: O(1)
/*