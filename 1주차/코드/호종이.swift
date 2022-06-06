//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/06/06.
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int(String($0)) }
let N = input[0]!
let M = input[1]!
// 인접 리스트 생성
var adjacentList: [Array<Int>] = .init(repeating: [], count: N + 1)

// 인접 리스트를 입력받는다.
for _ in 0..<M {
    let relation = readLine()!.components(separatedBy: " ").map { Int($0) }
    let A = relation[0]!
    let B = relation[1]!
    // A가 B를 신뢰한다. -> B를 해킹하면 A도 해킹가능
    adjacentList[B].append(A)
}

// Stack 을 활용한 dfs 를 구현한다. (단방향이기 때문에, 모든 정점을 다 검사해보자)
func dfs(start: Int, N: Int) -> Int {
    var visited: [Bool] = .init(repeating: false, count: N + 1)
    visited[start] = true
    var stack: [Int] = []

    stack.append(start)
    var count: Int = 0

    while !stack.isEmpty {
        count += 1
        let pop = stack.popLast()!

        for related in adjacentList[pop] {
            if !visited[related] {
                visited[related] = true
                stack.append(related)
            }
        }
    }
    return count
}
var max = -1
var counts: [Int] = []
for i in 1...N {
    let count = dfs(start: i, N: N)
    max = max < count ? count : max
    counts.append(count)
}
var answerString: String = ""
for i in 0..<N {
    if counts[i] == max {
        answerString += "\(i+1) "
    }
}

print(answerString)

