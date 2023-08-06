class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var maxHeight = 0
        var low = 0
        var high = height.count-1 // 8
        while low < high {
            if height[low] < height[high] { 
                maxHeight = max(maxHeight, height[low] * (high-low))
                low+=1
            } else { 
                maxHeight = max(maxHeight, height[high] * (high-low))
                high-=1
            }
        }
        return maxHeight
    }
}

/*
General idea: 
Use 2 pointers and decrement/increment pointer based on min height
Calculate container by (height-low) * min height

TC: O(N) 
SC: O(1)
*/