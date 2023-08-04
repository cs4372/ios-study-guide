class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rows = Array(repeating: Set<Character>(), count: 9)
        var cols = Array(repeating: Set<Character>(), count: 9)
        var boxes = Array(repeating: Set<Character>(), count: 9)

        for row in 0..<9 { 
            for col in 0..<9 { 
                var val = board[row][col]
                var box_id = 3 * (row/3) + (col/3)
                
                if val == "." { 
                    continue
                }
                if rows[row].contains(val) || cols[col].contains(val) || boxes[box_id].contains(val) { 
                    return false
                }
                rows[row].insert(val)
                cols[col].insert(val)
                boxes[box_id].insert(val)
            }
        }
        return true
    }
}

/*
TC: O(N^2)
SC: O(N^2)
/*
