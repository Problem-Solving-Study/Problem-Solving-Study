//
//  main.swift
//  1325
//
//  Created by COBY_PRO on 2022/06/09.
//

import Foundation

let input = readLine()!.components(separatedBy: " ").map { Int(String($0))! }
let N = input[0]
let M = input[1]
var graph: [Int:[Int]] = [:]

for i in 1...N {
    graph[i] = []
}

for _ in 1...M {
    let info = readLine()!.components(separatedBy: " ").map { Int(String($0))! }
    graph[info[1]]! += [info[0]]
}

func dfs(_ node: Int) -> Int {
    var hacking: Int = 0
    hacking += 1
    
    guard let next = graph[node] else { fatalError() }
    if next == [] {
        return 1
    }
    for next_node in next {
        hacking += dfs(next_node)
    }
    return hacking
}

var result = Array(repeating: 0, count: N + 1)

for k in graph.keys{
    result[k] = dfs(k)
}

var resultSt = ""
for (e, t) in result.enumerated(){
    if t == result.max(){
        resultSt.write(String(e) + " ")
    }
}

print(resultSt)
