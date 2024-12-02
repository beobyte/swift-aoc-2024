import Algorithms
import Foundation

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.split(separator: " ").compactMap { Int($0) }
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        entities.filter({ isValidReport($0) }).count
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        entities.map { $0.max() ?? 0 }.reduce(0, +)
    }
    
    func isValidReport(_ report: [Int]) -> Bool {
        let pairs = stride(from: 0, to: report.count - 1, by: 1).map {
            (report[$0], report[$0+1])
        }
        
        var reportOrder: ComparisonResult?
        for p in pairs {
            let pairOrder = compareInts(p.0, p.1)
            if let reportOrder, reportOrder != pairOrder {
                return false
            } else {
                reportOrder = pairOrder
            }
            
            let diff = abs(p.0 - p.1)
            if diff < 1 || diff > 3 {
                return false
            }
        }
        
        return true
    }
    
    func compareInts(_ a: Int, _ b: Int) -> ComparisonResult {
        if a < b { return .orderedAscending }
        else if a > b { return .orderedDescending }
        else { return .orderedSame }
    }
}
