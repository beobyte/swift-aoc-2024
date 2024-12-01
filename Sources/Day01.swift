import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            let a = $0.split(separator: "   ")
            return $0.split(separator: "   ").compactMap { Int($0) }
        }
    }
    
    func part1() -> Any {
        var columnLeft: [Int] = []
        var columnRight: [Int] = []
        entities.forEach { pair in
            columnLeft.append(pair[0])
            columnRight.append(pair[1])
        }
        columnLeft.sort()
        columnRight.sort()
        return zip(columnLeft, columnRight).reduce(0) { partialResult, pair in
            partialResult + abs(pair.0 - pair.1)
        }
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        entities.map { $0.max() ?? 0 }.reduce(0, +)
    }
}
