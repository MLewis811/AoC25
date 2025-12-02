//
//  MathFuncs.swift
//  AoC23
//
//  Created by Mike Lewis on 12/8/23.
//

import Foundation

// Greatest Common Denominator of Two #s
func gcd(_ a: Int, _ b: Int) -> Int {
    if a == 0 {
        return b
    }
    if b == 0 {
        return a
    }
    
    let x = max(a,b)
    let y = min(a,b)
    
    return gcd(y, (x % y))
}

// Least Common Multiple of Two #s
func lcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / gcd(a,b)
}

// Least Common Multiple of an Array of #s
func lcmm(_ nums: [Int] ) -> Int {
    if nums.count == 2 {
        return lcm(nums[0], nums[1])
    }
    
    let a = nums[0]
    let newNums = Array(nums[1...])
    return lcm(a,lcmm(newNums))
}

// Modulo operator that always returns a positive #
infix operator %%
extension Int {
    static  func %% (_ left: Int, _ right: Int) -> Int {
        if left >= 0 { return left % right }
        if left >= -right { return (left+right) }
        return ((left % right)+right)%right
    }
}

// Extended Greatest Common Divisor (Extended Euclidean Algorithm)
func extendedGCD(_ a: Int, _ b: Int) -> (x: Int, y: Int) {
    if b == 0 {
        return (1, 0)
    }
    
    let (x1, y1) = extendedGCD(b, a % b)
    let x = y1
    let y = x1 - y1 * (a / b)
    
    return (x,y)
}


// Exponent function for Ints
func powInt(base: Int, exponent: Int) -> Int {
    // Handle edge cases first
    guard exponent >= 0 else {
        preconditionFailure("Negative exponents not supported for integer results")
    }
    if exponent == 0 {
        return 1 // Any base^0 = 1 (except 0^0, which is undefined)
    }
    if base == 0 {
        return 0 // 0^exponent = 0 (for exponent > 0)
    }
    
    var result = 1
    var currentBase = base
    var currentExponent = exponent
    
    // Exponentiation by squaring: O(log(exponent)) time
    while currentExponent > 0 {
        if currentExponent % 2 == 1 {
            result *= currentBase // Multiply result by currentBase if exponent is odd
        }
        currentBase *= currentBase // Square the base
        currentExponent /= 2 // Halve the exponent (integer division)
    }
    return result
}


func getFactorPairs(of n: Int) -> [(Int, Int)] {
    var pairs: [(Int, Int)] = []
    for i in 1...Int(sqrt(Double(n))) {
        if n.isMultiple(of: i) {
            pairs.append((i, n/i))
        }
    }
    return pairs
}
