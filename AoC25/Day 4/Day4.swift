//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day4(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)

    var locs: Set<Loc> = []

    // Build locations safely using string indices
    var row = 0
    for line in lines {
        var col = 0
        for ch in line { // iterate characters directly
            if ch != "." { // keep only non-dots
                let isRoll = (ch == "@")
                locs.insert(Loc(r: row, c: col, isRoll: isRoll))
            }
            col += 1
        }
        row += 1
    }

    if part == 1 {
        for loc in locs {
            if countNeighbors(loc) < 4 {
                print("\(loc.c), \(loc.r)")
                tot += 1
            }
        }
    } else {
        let startCount = locs.count
        var reachable = locs.filter( { countNeighbors($0) < 4 })
        while reachable.count > 0 {
            locs.subtract(reachable)
            reachable = locs.filter( { countNeighbors($0) < 4 })
        }
        print(locs.count, startCount)
        tot = startCount - locs.count
    }

    print(tot)
    return "\(tot)"
    
    
    struct Loc: Hashable {
        let r: Int
        let c: Int
        let isRoll: Bool
    }
    
    func countNeighbors(_ loc: Loc) -> Int {
        var numNeighbors = 0
        let r = loc.r
        let c = loc.c

        // NW
        numNeighbors += locs.contains(Loc(r: r-1, c: c-1, isRoll: true)) ? 1 : 0
        
        // N
        numNeighbors += locs.contains(Loc(r: r-1, c: c, isRoll: true)) ? 1 : 0
        
        // NE
        numNeighbors += locs.contains(Loc(r: r-1, c: c+1, isRoll: true)) ? 1 : 0

        // W
        numNeighbors += locs.contains(Loc(r: r, c: c-1, isRoll: true)) ? 1 : 0

        // E
        numNeighbors += locs.contains(Loc(r: r, c: c+1, isRoll: true)) ? 1 : 0

        // SW
        numNeighbors += locs.contains(Loc(r: r+1, c: c-1, isRoll: true)) ? 1 : 0

        // S
        numNeighbors += locs.contains(Loc(r: r+1, c: c, isRoll: true)) ? 1 : 0

        // SE
        numNeighbors += locs.contains(Loc(r: r+1, c: c+1, isRoll: true)) ? 1 : 0

        return numNeighbors
    }
}


