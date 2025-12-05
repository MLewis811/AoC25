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
            print(line)
            if ranges.contains(where: { $0.min...$0.max ~= Int(line)! }) {
                tot += 1
            }
        }
        
    }
    
    print(tot)
    return "\(tot)"
    
    struct idRange: Hashable {
        let min: Int
        let max: Int
    }
}
