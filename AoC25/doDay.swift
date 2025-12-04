//
//  doDay.swift
//  AoC22
//
//  Created by Mike Lewis on 12/1/22.
//

import Foundation

func doDay(day: Int, file: String, part: Int) -> String {
    
    let dayFile = "day" + (String(day)) + file
    switch day {
    case 1:
        return Day1(file: dayFile, part: part)
    case 2:
        return Day2(file: dayFile, part: part)
    case 3:
        return Day3(file: dayFile, part: part)
    case 4:
        return Day4(file: dayFile, part: part)
    default:
        return ""
    }
}
