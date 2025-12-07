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
    
    /* Anticipating that Part 2 might need to know if #s are left- or right-justified */
    if part == 2 {
        var maxLen = 0
        for line in lines {
            if line.count > maxLen { maxLen = line.count }
        }
        
        let ops = lines[lines.count - 1].split(separator: " ", omittingEmptySubsequences: true).map { String( $0 )}
        var col = maxLen - 1
        var probNums: [Int] = []
        while col >= 0 {
            var colStr = ""
            for i in 0..<(lines.count - 1) {
                if col < lines[i].count {
                    colStr += lines[i][col]
                }
            }
            if colStr.replacingOccurrences(of: " ", with: "") != "" {
                probNums.append(Int(colStr.trimmingCharacters(in: .whitespacesAndNewlines))!)
            } else {
                print("Adding problem \(probNums): \(ops[ops.count - problems.count - 1])")
                problems.append(Problem(numbers: probNums, op: ops[ops.count - problems.count - 1]))
                probNums = []
            }
            
            /* Won't get the far-left problem if there's no col of whitespace at beginning, so add it now */
            if col == 0 {
                print("Adding problem \(probNums): \(ops[ops.count - problems.count - 1])")
                problems.append(Problem(numbers: probNums, op: ops[ops.count - problems.count - 1]))
            }
            
            col -= 1
        }
        
        for problem in problems {
            tot += problem.ans
        }
        
    } else {
        
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
            for lineNum in 0..<(splitLines.count - 1) {
                nums.append(Int(splitLines[lineNum][entryNum])!)
            }
            problems.append(Problem(numbers: nums, op: op))
        }
        
        print("\(problems[0].numbers): \(problems[0].op) = \(problems[0].ans)")
        
        for problem in problems {
            tot += problem.ans
        }
    }

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
