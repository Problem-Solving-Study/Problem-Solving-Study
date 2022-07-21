//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/07/12.
//

import Foundation


func isPrimeNumber(_ value: Int) -> Bool {
    if value == 1 {
        return false
    }
    if value == 2 || value == 3 {
        return true
    }
    for i in 2...Int(sqrt(Double(value))) {
        if value % i == 0 {
            return false
        }
    }
    return true
}

func findPrimeNumber() {
    _ = readLine()

    let arr: [Int] = readLine()!.components(separatedBy: " ").map { string in
        Int(string)!
    }

    var answer: Int = 0

    for number in arr {
        if isPrimeNumber(number) {
            answer += 1
        }
    }

    print(answer)
}

