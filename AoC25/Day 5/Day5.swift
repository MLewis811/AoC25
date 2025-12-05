//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day5(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    var ranges: Set<idRange> = []
    
    var inRanges = true
    for line in lines {
        if line.isEmpty {
            inRanges = false
            continue
        }
        
        if inRanges {
            let split = line.split(separator: "-")
            let min = Int(split[0])!
            let max = Int(split[1])!
            
            ranges.insert(idRange(min: min, max: max))
            
        } else {
            if part == 1 {
                
                if ranges.contains(where: { $0.min...$0.max ~= Int(line)! }) {
                    tot += 1
                }
            }
        }
    }
    
    if part == 2 {
        let sortedRanges: [idRange] = ranges.sorted { $0.min < $1.min }
        
        var combinedRanges: [idRange] = [sortedRanges[0]]
        for i in 1..<sortedRanges.count {
//            print("\(i): Compare \(sortedRanges[i].min)-\(sortedRanges[i].max) to \(combinedRanges[combinedRanges.count-1].min)-\(combinedRanges[combinedRanges.count-1].max)")
            if sortedRanges[i].min <= combinedRanges[combinedRanges.count-1].max {
                if sortedRanges[i].max >= combinedRanges[combinedRanges.count-1].max {
                    combinedRanges[combinedRanges.count-1].max = sortedRanges[i].max
                }
            } else {
                combinedRanges.append(sortedRanges[i])
            }
            
        }
        
        for cR in combinedRanges {
            tot += cR.max - cR.min + 1
            print("\(cR.min)...\(cR.max)")
        }
    }

    
    print(tot)
    return "\(tot)"
    
    struct idRange: Hashable {
        var min: Int
        var max: Int
    }
}
