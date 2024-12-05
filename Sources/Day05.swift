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
            partialResult += checkUpdate(update, rules: rules).middle ?? 0
        }
    }
    
    func part2() -> Any {
        updates
            .compactMap({ update in
                let fixedUpdate = fixUpdate(update, with: rules)
                return fixedUpdate == update ? nil : fixedUpdate
            })
            .reduce(0) { partialResult, fixedUpdate in
                partialResult + fixedUpdate[fixedUpdate.count/2]
            }
    }
    
    func checkUpdate(_ update: [Int], rules: [[Int]]) -> (middle: Int?, failedRule: [Int]?) {
        for i in 0..<update.count-1 {
            let rule = [update[min(i+1, update.count-1)], update[i]]
            if rules.contains(rule) {
                return (nil, rule)
            }
        }
        return (update[update.count/2], nil)
    }
    
    func fixUpdate(_ update: [Int], with rules: [[Int]]) -> [Int] {
        let (middle, failedRule) = checkUpdate(update, rules: rules)
        guard middle == nil else { return update }
        guard let failedRule,
              let index0 = update.firstIndex(of: failedRule[0]),
              let index1 = update.firstIndex(of: failedRule[1])
        else {
            fatalError("WTF? \(update) \(String(describing: failedRule))")
        }
        var updateCopy = update
        updateCopy.swapAt(index0, index1)
        return fixUpdate(updateCopy, with: rules)
    }
}
