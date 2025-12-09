//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day9(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    var tiles: [Tile] = []
    
    for line in lines {
        let coords = line.split(separator: ",").map { Int($0)! }
        tiles.append(Tile(x: coords[0], y: coords[1]))
    }
    
    var maxArea = 0
    var maxAreaTiles = [-1, -1]
    
    if part == 1 {
        for i in 0..<(tiles.count - 1) {
            for j in (i + 1)..<tiles.count {
                let area = area(tiles[i], tiles[j])
                if area > maxArea {
                    maxArea = area
                    maxAreaTiles = [i, j]
                }
            }
        }
        
        tot = maxArea
        print("Biggest rect: \(tiles[maxAreaTiles[0]].coordString), \(tiles[maxAreaTiles[1]].coordString) - area = \(maxArea)")
    } else {
        let maxX = tiles.map(\.x).max()!
        let maxY = tiles.map(\.y).max()!
        let minX = tiles.map(\.x).min()!
        let minY = tiles.map(\.y).min()!
        
        var grid: [[ColoredTile]] = []
        
        print("X: \(minX)-\(maxX), Y: \(minY)-\(maxY)")
    }
    
    print(tot)
    return "\(tot)"
    
    struct Tile: Hashable {
        let x, y: Int
        
        var coordString: String {
            "\(x),\(y)"
        }
    }
    
    struct ColoredTile: Hashable {
        let tile: Tile
        let color: Int
    }
    
    enum TileColor: Int {
        case black, red, green
    }
    
    func area(_ t1: Tile, _ t2: Tile) -> Int {
        (abs(t1.x - t2.x) + 1) * (abs(t1.y - t2.y) + 1)
    }
}
