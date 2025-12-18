//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day10(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    for line in lines {
        let splitLine = line.split(separator: " ")
        let numBits = splitLine[0].count - 2
        var goal = 0
        for i in 1..<splitLine[0].count - 1 {
            if splitLine[0][i] == "#" { goal += 1 }
            goal = goal << 1
        }
        goal = goal >> 1
        print("\(splitLine[0]) - \(goal)")
        var schematicInts: [Int] = []
        for i in 1..<splitLine.count - 1 {
            let strippedSchematic = String(splitLine[i][1..<(splitLine[i].count-1)])
            let wireNums = strippedSchematic.split(separator: ",").map { Int($0)! }
            schematicInts.append(getIntFromBits(wireNums, bitWidth: numBits))
        }
        print("\(splitLine[0]) - \(schematicInts)")
    }
    
    let bitsIn = [1,3]
    print("\(bitsIn) - \(getIntFromBits(bitsIn, bitWidth: 4))")

    print(tot)
    return "\(tot)"
    
    func getIntFromBits(_ bits: [Int], bitWidth: Int) -> Int {
        var result = 0
        
        let sortedBits = bits.sorted()
        for bit in sortedBits {
            result = result | (1 << (bitWidth - bit - 1))
        }
        
        return result
    }
}
