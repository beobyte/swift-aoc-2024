import Algorithms

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [[Character]] {
        data.split(separator: "\n").map(Array.init)
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return search(word: ["X", "M", "A", "S"], in: entities)
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        0
    }
    
    func search(word: [Character], in text: [[Character]]) -> Int {
        let m = text.count;
        let n = text[0].count;
        
        var count = 0
        
        for i in 0..<m {
            for j in 0..<n {
                count += search(word: word, in: text, row: i, col: j)
            }
        }
        
        return count
    }
    
    func search(word: [Character], in text: [[Character]], row: Int, col: Int) -> Int {
        let m = text.count;
        let n = text[0].count;
    
        var count = 0
        if text[row][col] != word[0] {
            return 0
        }

        let x = [-1, -1, -1, 0, 0, 1, 1, 1]
        let y = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        for i in 0..<x.count {
            var curX = row + x[i]
            var curY = col + y[i]
            
            var k = 1
            
            while k < word.count {
                if curX >= m || curX < 0 || curY >= n || curY < 0 {
                    break
                }
                
                if text[curX][curY] != word[k] {
                    break
                }
                
                curX += x[i]
                curY += y[i]
                k += 1
            }
            
            if k == word.count {
                count += 1
            }
        }
        
        return count
    }
}
