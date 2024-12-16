import Algorithms

struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [Int: [Int]] {
        var result: [Int: [Int]] = [:]
        data.split(separator: "\n").forEach {
            let components = $0.components(separatedBy: ":")
            let key = Int(components[0])!
            let values = components[1].components(separatedBy: " ").compactMap({ Int($0) })
            result[key] = values
        }
        return result
    }
    
    func part1() -> Any {
        entities.reduce(into: 0) { partialResult, pair in
            partialResult += canCombine(values: pair.value, for: pair.key) ? pair.key : 0
        }
    }
    
    func part2() -> Any {
        0
    }
    
    func canCombine(values: [Int], for result: Int) -> Bool {
        guard values.count > 2 else {
            return values[0] + values[1] == result
            || values[0] * values[1] == result
        }
        
        if canCombine(values: [values[0] + values[1]] + Array(values[2...]), for: result) {
            return true
        }
        
        if canCombine(values: [values[0] * values[1]] + Array(values[2...]), for: result) {
            return true
        }
        
        return false
    }
}
