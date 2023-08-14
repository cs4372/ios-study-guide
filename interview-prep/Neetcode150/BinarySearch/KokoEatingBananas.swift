class Solution {
    func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
        var low = 1
        var high = piles.max()!
        var minInt = high
        while low <= high { 
            var mid = (low+high)/2
            var hrs = 0
            for pile in piles {
                hrs += Int(ceil(Double(pile)/Double(mid)))
            }
            if hrs <= h { 
                minInt = min(minInt, mid)
                high = mid - 1
            } else {
               low = mid + 1
            }
        }
        return minInt
    }
}

/*
piles = [3,6,7,11], h = 8
General idea: Get the minimum hours within h hours
Koko eats k number of bananas per hour 
1 2 3 4 5 6 7 8 9 10 11
Use binary search to get middle value (low+high)/2

Calculate the total number of hours Koko can finish eating all bananas (round up the number)
e.g. middle value is 6
3 (bananas)/6 + 6/6 + 7/6 + 11/8 
- if hrs < h, set minVal and high = mid - 1 
- else low = mid + 1

TC: O(nlogm) => n be the number of piles and m be the max num of bananas from piles
SC: O(1)
/*