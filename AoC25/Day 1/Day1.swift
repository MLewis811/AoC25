//
//  Day1.swift
//  AoC24
//
//  Created by Mike Lewis on 11/25/24.
//

import Foundation

func Day1(file: String, part: Int) -> String {
    let lines = loadStringsFromFile(file)
    
    var pos = 50
    
    var tot = 0
    

    
    if part == 1 {
        for line in lines {
            let dir = line[0]
            let dist = Int(line[1...])!
            if dir == "L" {
                pos -= dist
            } else {
                pos += dist
            }
            while pos < 0 {
                pos += 100
            }
            while pos >= 100 {
                pos -= 100
            }
            print("\(dir) \(dist) - pos: \(pos)")
            tot += pos == 0 ? 1 : 0
        }
    } else {
        for line in lines {
            let dir = line[0]
            let dist = Int(line[1...])!
            var newpos: Int
            if dir == "L" {
                newpos = pos - dist
            } else {
                newpos = pos + dist
            }
            while newpos < 0 {
                newpos += 100
                tot += 1

            }
            while newpos >= 100 {
                newpos -= 100
                tot += 1
            }
            if (pos == 0 && dir == "L") || (newpos == 0 && dir == "R"){
                tot -= 1
            }
            pos = newpos
            tot += pos == 0 ? 1 : 0
            print("\(dir) \(dist) - pos: \(pos) - tot: \(tot)")

        }
        
    }

        
    return "\(tot)"
}
