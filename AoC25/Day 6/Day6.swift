//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day6(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)

    var problems: [Problem] = []
    var splitLines: [[String]] = []
    
    for i in 0..<lines.count {
        let line = lines[i]
        let nums = line.split(separator: " ", omittingEmptySubsequences: true).map { String($0) }
        print( nums )
        splitLines.append(nums)
    }
    
    /* Just making sure we have the same # of entries in each line */
    for splitLine in splitLines {
        print(splitLine.count)
    }
    
    for entryNum in 0..<splitLines[0].count {
        var nums: [Int] = []
        let op = splitLines[splitLines.count - 1][entryNum]
        for lineNum in 0..<(splitLines.count - 2) {
            nums.append(Int(splitLines[lineNum][entryNum])!)
        }
        problems.append(Problem(numbers: nums, op: op))
    }
    
    print("\(problems[0].numbers): \(problems[0].op) = \(problems[0].ans)")
    

    print(tot)
    return "\(tot)"
    
    struct Problem {
        let numbers: [Int]
        let op: String
        
        var ans: Int {
            if op == "+" {
                var n = 0
                for number in numbers { n += number }
                return n
            } else if op == "*" {
                var n = 1
                for number in numbers { n *= number }
                return n
            } else {
                print("INVALID OP: \(op)")
                return -1
            }
        }
    }
    
}
