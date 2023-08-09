class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let col = matrix[0].count
        var low = 0
        var high = matrix.count-1
        while low <= high {
            var mid = (low+high)/2
            var currRow = matrix[mid]
            if target < currRow[0] { 
                high-=1
            } else if target > currRow[col-1] { 
                low+=1
            }  else { 
                low = 0
                high = matrix[0].count-1
                while low <= high { 
                    mid = (low+high)/2
                    if currRow[mid] == target { 
                        return true
                    }
                    if currRow[mid] < target {
                        low+=1
                    } else {
                        high-=1
                    }
                }
            }
        }
        return false
    }
}

/*
TC: O(log(m*n)) - Do a binary search for the row, and once you find the row, do another binary search within that row to look for the target
SC: O(1)
*/