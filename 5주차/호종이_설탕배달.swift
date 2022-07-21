//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/07/10.
//

import Foundation



func canMakePair(_ weight: Int) -> (result: Bool, remain: Int) {
    let remain = weight % 3
    return (remain == 0, remain)
}

func deliverSugar() {

    let N: Int = Int(readLine()!)!
    var fiveKiloWeight: Int = (N / 5) * 5 // 5키로 짜리로 최대한 많이 들고, 나머지를 3키로 짜리로 전부 들 수 있으면 그게 최소 봉지 개수다
    var remainWeight = N - fiveKiloWeight

    while fiveKiloWeight >= 0 {
        let result = canMakePair(remainWeight)
        if result.result {
            break
        }
        fiveKiloWeight -= 5
        remainWeight = result.remain + 5
    }

    if fiveKiloWeight < 0 {
        print(-1)
    } else {
        print((fiveKiloWeight / 5) + (N - fiveKiloWeight) / 3)
    }
}




