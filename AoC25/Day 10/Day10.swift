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
    
    if part == 1 {
        for line in lines {
            let splitLine = line.split(separator: " ")
            let numBits = splitLine[0].count - 2
            var goal = 0
            for i in 1..<splitLine[0].count - 1 {
                if splitLine[0][i] == "#" { goal += 1 }
                goal = goal << 1
            }
            goal = goal >> 1
//            print("\(splitLine[0]) - \(goal)")
            var schematicInts: [Int] = []
            for i in 1..<splitLine.count - 1 {
                let strippedSchematic = String(splitLine[i][1..<(splitLine[i].count-1)])
                let wireNums = strippedSchematic.split(separator: ",").map { Int($0)! }
                schematicInts.append(getIntFromBits(wireNums, bitWidth: numBits))
            }
//            print("\(splitLine[0]) - \(schematicInts)")
            
            var numPushes = 1
            var hitGoal = false
            while numPushes <= schematicInts.count && !hitGoal {
                if let result = pressButton(goal: goal, currentState: 0, in: schematicInts, numPush: numPushes, pushed: []) {
                    print("\(splitLine[0]) - \(result)")
                    hitGoal = true
                    tot += result.count
                }
                numPushes += 1
            }
//            print(pressButton(goal: goal, currentState: 0, in: schematicInts, numPush: 3, pushed: []))
        }
    }
    


    print(tot)
    return "tot = \(tot)"
    
    func pressButton(goal: Int, currentState: Int, in schematic: [Int], numPush: Int, pushed: [Int]) -> [Int]? {
        if currentState == goal { return pushed }
        
        if numPush == 0 { return nil }
        
        for i in 0..<schematic.count {
            let button = schematic[i]
            let newState = currentState ^ schematic[i]
            let newPushed = pushed + [button]
            
            if newState == goal {
                return newPushed
            }
            
            let remainingSchema = Array(schematic[(i+1)...])
            
            if let result = pressButton(
                goal: goal,
                currentState: newState,
                in: remainingSchema,
                numPush: numPush - 1,
                pushed: newPushed
            ) {
                return result
            }
        }
        
        return nil
        
    }
    
    func getIntFromBits(_ bits: [Int], bitWidth: Int) -> Int {
        var result = 0
        
        let sortedBits = bits.sorted()
        for bit in sortedBits {
            result = result | (1 << (bitWidth - bit - 1))
        }
        
        return result
    }
}
