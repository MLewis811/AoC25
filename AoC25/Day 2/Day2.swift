//
//  DayTemplate.swift
//  AoC24
//
//  Created by Mike Lewis on 12/3/24.
//

import Foundation

func Day2(file: String, part: Int) -> String {
    var tot = 0
    let lines = loadStringsFromFile(file)
    
    let line = lines[0]
    
    var ranges: [idRange] = []
    
    let rangeStrs = line.split(separator: ",")
    for rangeStr in rangeStrs {
        let vals = rangeStr.split(separator: "-")
        ranges.append(idRange(start: String(vals[0]), end: String(vals[1])))
        print("\(rangeStr): \(vals)")
    }


    
    if part == 1 {
        for i in 0..<ranges.count {
            let reducedRg = reduceRange(ranges[i])
            print("\(ranges[i]) - \(reducedRg)")
            ranges[i] = reducedRg
        }
        print("Before : \(ranges.count)")
        ranges = ranges.filter { $0.startInt <= $0.endInt }
        print("After : \(ranges.count)")
        
        for rg in ranges {
            print("*** Considering \(rg.start)-\(rg.end) ***")
            let firstHalf = String(rg.start[0..<(rg.start.count / 2)])
            var firstHalfInt = Int(firstHalf)!
            var testNum = firstHalf + firstHalf
            while (Int(testNum)! <= rg.endInt) {
                if Int(testNum)! >= rg.startInt {
                    print("\(rg.start)-\(rg.end): \(testNum)")
                    tot += Int(testNum)!
                }
                firstHalfInt += 1
                testNum = "\(firstHalfInt)\(firstHalfInt)"
            }
        }
    } else {
        var invalidIDs: Set<Int> = []
        
        for rg in ranges {
            for testNum in rg.startInt...rg.endInt {
                if isRepeating(testNum) {
                    invalidIDs.insert(testNum)
                }
            }
        }
        print(invalidIDs.sorted())
        for id in invalidIDs {
            tot += id
        }
    }
    
    print("tot: \(tot)")

//    print(isRepeating(565656))
    
    return "\(tot)"
    
    func isRepeating(_ num: Int) -> Bool {
//        print("Is \(num) repeating?")
                
        let divs = makeallDivisors(under: num)
        for div in divs {
            if num.isMultiple(of: div) {
                let testQuot = num / div
                var newStr = "\(testQuot)"
                while newStr.count < "\(num)".count {
                    newStr += "\(testQuot)"
                }
                if newStr == "\(num)" {
//                    print("\(num) repeating! - div \(div)")
                    return true
                }
            }
        }
        
        return false
    }
    
    func makeallDivisors(under: Int) -> [Int] {
        var divs: [Int] = []
        
        var didOne = true
        var numZeros = 0
        while didOne {
            didOne = false
            
            var numRepeats = 1
            var repDiv = makeRepeatedDivisor(numZeros: numZeros, numRepetitions: numRepeats)
            while repDiv <= under {
                divs.append(repDiv)
                didOne = true
                numRepeats += 1
                repDiv = makeRepeatedDivisor(numZeros: numZeros, numRepetitions: numRepeats)
            }
            
            numZeros += 1
        }
        
        return divs
    }
    
    func makeRepeatedDivisor(numZeros: Int, numRepetitions: Int) -> Int {
        let baseNum = powInt(base: 10, exponent: numZeros)
        if numRepetitions == 0 {
            return 1
        }
        var newNum: Int = baseNum
        for _ in 1..<numRepetitions {
            newNum = newNum * powInt(base: 10, exponent: numZeros + 1) + baseNum
        }
        
        return newNum * 10 + 1
    }
    
    
    func reduceRange(_ rg: idRange) -> idRange {
        var rgStart = rg.start
        let startLen = rg.start.count
        if startLen % 2 == 1 {
            var newStart = "1"
            for _ in 0..<startLen {
                newStart += "0"
            }
            rgStart = newStart
        }
        
        var rgEnd = rg.end
        let endLen = rg.end.count
        if endLen % 2 == 1 {
            var newEnd = "9"
            for _ in 0..<(endLen - 2) {
                newEnd += "9"
            }
            rgEnd = newEnd
        }
        
        return idRange(start: rgStart, end: rgEnd)
    }
    
    struct idRange {
        var start: String
        var end: String
        
        var startInt: Int { Int(start)! }
        var endInt: Int { Int(end)! }
    }
}
