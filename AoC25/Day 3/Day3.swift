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
    
//    print(banks)
    
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
        let numDigits = 12
        
        for bank in banks {
            getBigNum(bank, len: numDigits, numSoFar: 0)
        }
    }

    print(tot)
    return "\(tot)"
    
    func getBigNum(_ digits: [Int], len: Int, numSoFar: Int) {
        var num: Int
        
        if len == 0 {
            print(numSoFar)
            tot += numSoFar
            return
        }
        
        // I don't think this should ever happen...
        if digits.count == 0 {
            print("EMPTY???")
            return
        }

        num = largestDigitWithNAfter(digits, n: len - 1)
        let idx = digits.firstIndex(of: num)!
        num = numSoFar * 10 + num
        getBigNum(Array(digits[(idx+1)...]), len: len - 1, numSoFar: num)

        
        return
    }
    
    func largestDigitWithNAfter(_ digits: [Int], n: Int) -> Int {
        let head = digits[0..<(digits.count - n)]
        return head.max()!
    }
    
    func arrayToNum(_ a: [Int]) -> Int {
        var num:Int = 0
        var i = 0
        while i < a.count {
            num = num * 10 + a[i]
            i += 1
        }
        return num
    }
    
    func combinations(of digits: [Int], choose k: Int) -> Set<[Int]> {
        var results: Set<[Int]> = []
        
        func backtrack(_ start: Int, _ current: [Int]) {
            if current.count == k {
                results.insert(current)
                return
            }
            
            guard start < digits.count else { return }
            
            for i in start..<digits.count {
                backtrack(i + 1, current + [digits[i]])
            }
        }
        
        backtrack(0, [])
        
        return results
    }
    
    struct batteryPair {
        var a: Int
        var b: Int
        
        var val:Int { a * 10 + b }
    }
}
