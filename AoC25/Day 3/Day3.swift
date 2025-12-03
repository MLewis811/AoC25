//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day3(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    var banks:[[Int]] = []
    for line in lines {
        var bank:[Int] = []
        for i in 0..<line.count {
            bank.append(Int(line[i])!)
        }
        banks.append(bank)
    }
    
    print(banks)
    
    if part == 1 {
        for bank in banks {
            var greatestBat = batteryPair(a: 0, b: 0)
            for i in 0..<(bank.count - 1) {
                for j in i+1..<bank.count {
                    if batteryPair(a: bank[i], b: bank[j]).val > greatestBat.val {
                        greatestBat = batteryPair(a: bank[i], b: bank[j])
                    }
                }
            }
            print(greatestBat)
            tot += greatestBat.val
        }
    } else {

        
    }

    print(tot)
    return "\(tot)"
    
    struct batteryPair {
        var a: Int
        var b: Int
        
        var val:Int { a * 10 + b }
    }
}
