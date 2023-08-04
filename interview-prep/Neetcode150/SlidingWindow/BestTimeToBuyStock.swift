class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var minPrice = prices[0]
        var ans = 0

        for price in prices { 
            minPrice = min(minPrice, price)
            ans = max(ans, price-minPrice)
        }
        return ans
    }
}

/*
Time Complexity: O(n)
Space Complexity: O(1)
*/