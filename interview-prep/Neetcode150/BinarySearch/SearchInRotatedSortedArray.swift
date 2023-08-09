class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var low = 0
        var high = nums.count-1
         if nums.count == 1 {
            return nums[0] == target ? 0 : -1
        }
        while low <= high { 
            var mid = (low+high)/2
            var midVal = nums[mid]
            if midVal == target { 
                return mid
            }
            else if nums[low] <= midVal { 
                if nums[low] <= target && target < midVal { 
                    high = mid - 1
                } else { 
                    low = mid + 1
                }
            } else {
                if midVal < target && target <= nums[high] { 
                    low = mid + 1
                } else {
                    high = mid - 1
                }
            }
        }
        return -1
    }
}

/*
TC: O(logn)
SC: O(1)
*/