import Algorithms

struct Day05: AdventDay {
    var data: String
    
    var rules: [[Int]] {
        data.split(separator: "\n\n")[0]
            .split(separator: "\n")
            .map({ $0.split(separator: "|") })
            .map({ $0.map({ Int($0)! }) })
    }
    
    var updates: [[Int]] {
        data.split(separator: "\n\n")[1]
            .split(separator: "\n")
            .map({ $0.split(separator: ",") })
            .map({ $0.map({ Int($0)! }) })
    }
    
    func part1() -> Any {
        updates.reduce(into: 0) { partialResult, update in
            partialResult += correctMiddle(of: update, rules: rules) ?? 0
        }
    }
    
    func part2() -> Any {
        0
    }
    
    func correctMiddle(of update: [Int], rules: [[Int]]) -> Int? {
        for i in 0..<update.count-2 {            
            if rules.contains([update[i+1], update[i]]) {
                return nil
            }
        }
    
        return update[update.count/2]
    }
}
