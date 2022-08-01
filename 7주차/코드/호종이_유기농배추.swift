//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/08/01.
//

func organicBachoo() {
    let T = Int(readLine()!)!

    for _ in 0..<T {
        print(executeTestcase())
    }
}

func executeTestcase() -> Int {
    let input = readLine()!.split(separator: " ").map({ substring in
        Int(substring)!
    })
    let M = input[0] // 가로길이
    let N = input[1] // 세로길이
    let K = input[2] // 배추가 심어져 있는 위치의 개수

    var map: [[Bool]] = Array(repeating: Array(repeating: false, count: M), count: N)

    let dxDy: [(dx: Int, dy: Int)] = [(-1, 0), (0, -1), (1, 0), (0, 1)]

    readBaeChooPosition()
    func readBaeChooPosition() {
        for _ in 0..<K {
            let positionInput: [Int] = readLine()!.split(separator: " ").map {
                Int($0)!
            }
            map[positionInput[1]][positionInput[0]] = true
        }
    }

    func dfs(x: Int, y: Int) {
        map[y][x] = false
        for move in dxDy {
            let X = x + move.dx
            let Y = y + move.dy

            if canMove(x: X, y: Y) {
                dfs(x: X, y: Y)
            }
        }
    }

    func canMove(x: Int, y: Int) -> Bool {
        return x>=0 && y>=0 && x<M && y<N && map[y][x]
    }

    var ret = 0
    for y in 0..<N {
        for x in 0..<M {
            if map[y][x] {
                dfs(x: x, y: y)
                ret += 1
            }
        }
    }
    return ret
}

organicBachoo()
