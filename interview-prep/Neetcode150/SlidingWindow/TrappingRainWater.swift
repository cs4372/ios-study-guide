class Solution {
    func trap(_ height: [Int]) -> Int {
        var res = 0
        var left = 0
        var right = height.count-1
        var maxLeft = height[0]
        var maxRight = height[height.count-1]
        while left < right { 
            if maxLeft < maxRight { 
                left+=1
                maxLeft = max(maxLeft, height[left]) // get max left 
                res+=(maxLeft-height[left]) // calculate res by subtracting maxleft from the next height value
            } else {
                right-=1
                maxRight = max(maxRight, height[right])
                res+=(maxRight-height[right])
            }
        }
        return res
    }
}

/*
General idea: 
- Keep track of left and right height using 2 pointers
- Increment maxLeft and maxRight pointers depending on the max value on each side
- Calculate trapped water between the current left and right pointers by subtracting the current height from the corresponding max height

TC: O(N)
SC: O(1)
*/