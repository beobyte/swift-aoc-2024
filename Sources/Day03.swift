import Algorithms
import RegexBuilder

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [(a: Int, b: Int, skip: Bool)] {
        let intRef = Reference(Int.self)
        
        let pattern = Regex {
            ChoiceOf {
                "don't()"
                "do()"
                Regex {
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
                }
            }
        }.anchorsMatchLineEndings()
        
        var skip = false
        return data.matches(of: pattern).compactMap { match in
            print(match.output)
            let (substring, num1, num2) = match.output
            if substring.hasPrefix("do") {
                skip = substring.hasPrefix("don")
            }
            guard let num1, let num2 else { return nil }
            return (num1, num2, skip)
        }
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        return entities.reduce(0) { partialResult, entity in
            partialResult + entity.a * entity.b
        }
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return entities.reduce(0) { partialResult, entity in
            partialResult + (entity.skip ? 0 : (entity.a * entity.b))
        }
    }
}
