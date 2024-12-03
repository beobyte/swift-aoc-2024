import Algorithms
import RegexBuilder

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [(Int, Int)] {
        let intRef = Reference(Int.self)
        
        let pattern = Regex {
            "mul("
            Capture(as: intRef) {
                Regex {
                    ("0"..."9")
                    Optionally(("0"..."9"))
                    Optionally(("0"..."9"))
                }
            } transform: { intRef in
                Int(intRef) ?? 0
            }
            ","
            Capture(as: intRef) {
                Regex {
                    ("0"..."9")
                    Optionally(("0"..."9"))
                    Optionally(("0"..."9"))
                }
            } transform: { intRef in
                Int(intRef) ?? 0
            }
            ")"
        }.anchorsMatchLineEndings()
        
        return data.matches(of: pattern).map { match in
            let (_, num1, num2) = match.output
            return (num1, num2)
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        return entities.reduce(0) { partialResult, pair in
            partialResult + pair.0 * pair.1
        }
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        0
    }
}
