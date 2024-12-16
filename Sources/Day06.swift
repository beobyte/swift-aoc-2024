import Algorithms
import Foundation

struct Day06: AdventDay {
    struct Point: Hashable {
        static let outsideMapPoint = Point(x: NSNotFound, y: NSNotFound)
        let x: Int
        let y: Int
    }
    
    enum Direction {
        case up
        case right
        case down
        case left
        
        func next() -> Direction {
            switch self {
            case .up: .right
            case .right: .down
            case .down: .left
            case .left: .up
            }
        }
    }
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    func part1() -> Any {
        var paths = Set<Point>()
        var direction: Direction = .up
        let grid = data.split(separator: "\n").map(String.init)
        let guardPoint = locations(of: "^", in: grid)[0]
        
        paths.insert(guardPoint)
        
        var shouldStop = false
        var path = move(to: direction, from: guardPoint, in: grid, shouldStop: &shouldStop)
        while shouldStop == false {
            paths.formUnion(path)
            direction = direction.next()
            path = move(to: direction, from: path.last!, in: grid, shouldStop: &shouldStop)
        }
        paths.formUnion(path)
        
        return paths.count
    }
    
    func part2() -> Any {
        let grid = data.split(separator: "\n").map(String.init)
        let guardPoint = locations(of: "^", in: grid)[0]
        let availablePathPointsCount = locations(of: ".", in: grid).count
        var loopObstructionCount = 0
        
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                autoreleasepool {
                    var line = Array(grid[i])
                    if line[j] == "." {
                        line[j] = "#"
                        
                        var gridCopy = grid
                        gridCopy[i] = String(line)
                        
                        var paths = [Point]()
                        paths.append(guardPoint)
                        var direction: Direction = .up
                        
                        var shouldStop = false
                        var path = move(to: direction, from: guardPoint, in: gridCopy, shouldStop: &shouldStop)
                        while shouldStop == false, paths.count <= availablePathPointsCount - 1 {
                            paths.append(contentsOf: path)
                            direction = direction.next()
                            path = move(to: direction, from: paths.last!, in: gridCopy, shouldStop: &shouldStop)
                        }
                        paths.append(contentsOf: path)
                        
                        if paths.count > availablePathPointsCount - 1 {
                            loopObstructionCount += 1
                        }
                    }
                }
            }
        }
        
        return loopObstructionCount
    }
    
    func locations(of character: Character, in grid: [String]) -> [Point] {
        var locations: [Point] = []
        for (i, line) in grid.enumerated() {
            for (j, char) in line.enumerated() {
                if char == character {
                    locations.append(Point(x: j, y: i))
                }
            }
        }
        return locations
    }
    
    func move(to direction: Direction, from point: Point, in grid: [String], shouldStop: inout Bool) -> [Point] {
        var path = [Point]()
        
        var prev = point
        var next = nextPoint(to: direction, from: point, in: grid)
        while next != prev && next != Point.outsideMapPoint {
            path.append(next)
            prev = next
            next = nextPoint(to: direction, from: prev, in: grid)
        }
        shouldStop = next == Point.outsideMapPoint
        return path
    }
    
    func nextPoint(to direction: Direction, from point: Point, in grid: [String]) -> Point {
        let move: (x: Int, y: Int)
        switch direction {
        case .up:
            move = (0, -1)
        case .right:
            move = (1, 0)
        case .down:
            move = (0, 1)
        case .left:
            move = (-1, 0)
        }
        
        let pointX = point.x + move.x
        let pointY = point.y + move.y
        if pointX < 0 || pointX >= grid[0].count || pointY < 0 || pointY >= grid.count {
            return Point.outsideMapPoint
        }
        
        let line = Array(grid[pointY])
        if line[pointX] == "#" {
            return point
        }
        
        return Point(x: pointX, y: pointY)
    }
}
