//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day7(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    var finalLines = [lines[0]]
    for line in lines[1...] {
        var newLine = line
        
        for col in 0..<line.count {
            if newLine[col] == "^" && finalLines[finalLines.count - 1][col] == "|" {
                let leftIdx = newLine.index(newLine.startIndex, offsetBy: col - 1)
                let rightIdx = newLine.index(newLine.startIndex, offsetBy: col + 1)
                newLine.replaceSubrange(leftIdx...leftIdx, with: "|")
                newLine.replaceSubrange(rightIdx...rightIdx, with: "|")
                tot += 1
            } else if newLine[col] == "." &&
                (finalLines[finalLines.count - 1][col] == "|" ||
                finalLines[finalLines.count - 1][col] == "S") {
                let idx = newLine.index(newLine.startIndex, offsetBy: col)
                newLine.replaceSubrange(idx...idx, with: "|")
            }
        }
        finalLines.append(newLine)
//        print("******")
//        for finalLine in finalLines {
//            print(finalLine)
//        }
    }
    
    if part == 2 {
        tot = 0
        
        var lineCounts: [[Int]] = Array(repeating: Array(repeating: 0, count: finalLines[0].count), count: finalLines.count)
        
        let lastLineNum = lineCounts.count - 1
        for i in 0..<lineCounts[lastLineNum].count {
            if finalLines[lastLineNum][i] == "|" { lineCounts[lastLineNum][i] = 1 }
        }
        
        for lineNum in stride(from: finalLines.count - 2, through: 0, by: -1) {
            for col in 0..<finalLines[lineNum].count {
                if finalLines[lineNum][col] == "|" {
                    if finalLines[lineNum + 1][col] == "^" {
                        lineCounts[lineNum][col] = lineCounts[lineNum + 1][col + 1] + lineCounts[lineNum + 1][col - 1]
                    } else {
                        lineCounts[lineNum][col] = lineCounts[lineNum + 1][col]
                    }
                } else if finalLines[lineNum][col] == "S" {
                    lineCounts[lineNum][col] = lineCounts[lineNum + 1][col]
                }
            }
        }
        
        for i in 0..<lineCounts[0].count {
            if finalLines[0][i] == "S" { tot = lineCounts[0][i] }
        }
    }
    
    
    print(tot)
    return "\(tot)"
}
