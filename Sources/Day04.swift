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
        return search(word: ["X", "M", "A", "S"], in: entities).count
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let aLetters = search(word: ["M", "A", "S"], in: entities)
            .filter({ w in
                // skip horizontal and vertical words
                w[0].0 != w[1].0 && w[0].1 != w[1].1
            })
            .map({ w in
                // get only A letters coordinates hash
                var hasher = Hasher()
                hasher.combine(w[1].0)
                hasher.combine(w[1].1)
                return hasher.finalize()
            })
        return aLetters.count - Set(aLetters).count
    }
    
    func search(word: [Character], in text: [[Character]]) -> [[(Int, Int)]] {
        let m = text.count;
        let n = text[0].count;
        
        var result = [[(Int, Int)]]()
        
        for i in 0..<m {
            for j in 0..<n {
                result.append(contentsOf: search(word: word, in: text, row: i, col: j))
            }
        }
        
        return result
    }
    
    func search(word: [Character], in text: [[Character]], row: Int, col: Int) -> [[(Int, Int)]] {
        let m = text.count;
        let n = text[0].count;
    
        var count = 0
        if text[row][col] != word[0] {
            return []
        }
        
        var result = [[(Int, Int)]]()

        let x = [-1, -1, -1, 0, 0, 1, 1, 1]
        let y = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        for i in 0..<x.count {
            var curX = row + x[i]
            var curY = col + y[i]
            var wordPoints = [(row, col)]
            
            var k = 1
            
            while k < word.count {
                if curX >= m || curX < 0 || curY >= n || curY < 0 {
                    break
                }
                
                if text[curX][curY] != word[k] {
                    break
                }
                
                wordPoints.append((curX, curY))
                
                curX += x[i]
                curY += y[i]
                k += 1
            }
            
            if k == word.count {
                result.append(wordPoints)
                count += 1
            }
        }
        
        return result
    }
}
