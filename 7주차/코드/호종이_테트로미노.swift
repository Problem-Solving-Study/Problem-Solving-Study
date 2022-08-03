//
//  Tetromino.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/08/03.
//

final class Tetromino: AlgorithmProblem {

    var N: Int! // 종이의 세로 크기
    var M: Int! // 종이의 가로 크기
    var map: [[Int]]! // 종이
    var answer: String = ""

    var max: Int = -1
    let UNABLE = -1

    let dxDy: [(dx: Int, dy: Int)] = [(-1,0),(0,-1),(1,0),(0,1)]
    let combination: [[Int]] = [[0,1,2],[0,1,3],[0,2,3],[1,2,3]]
    func readInput() {
        let mapSize: [Int] = readLine()!.split(separator: " ").map({ Int($0)! })
        N = mapSize[0]
        M = mapSize[1]

        map = []

        for _ in 0..<N {
            let mapRow: [Int] = readLine()!.split(separator: " ").map({Int($0)!})
            map.append(mapRow)
        }
    }

    func solution() {
        for y in 0..<N {
            for x in 0..<M {
                dfs(x: x, y: y, count: 0, sum: 0)
                max = Swift.max(calculateSpecialShape(x: x, y: y), max)
            }
        }
        answer = String(max)
    }

    private func dfs(x: Int, y:Int, count: Int, sum: Int) {
        guard count != 4 else {
            max = Swift.max(max, sum)
            return
        }
        let temp: Int = map[y][x]
        map[y][x] = UNABLE
        for move in dxDy {
            let X: Int = x + move.dx
            let Y: Int = y + move.dy
            if canMove(x: X, y: Y) {
                dfs(x: X, y: Y, count: count + 1, sum: sum + temp)
            }
        }
        map[y][x] = temp
    }

    private func calculateSpecialShape(x: Int, y: Int) -> Int {
        var max = -1
        for way in combination {
            var sum = map[y][x]
            for index in way {
                let X: Int = x + dxDy[index].dx
                let Y: Int = y + dxDy[index].dy

                if canMove(x: X, y: Y) {
                    sum += map[Y][X]
                }
            }
            max = Swift.max(max,sum)
        }

        return max
    }

    private func canMove(x: Int, y: Int) -> Bool {
        return x>=0&&y>=0&&x<M&&y<N && map[y][x] != UNABLE
    }
}

let tetromino: Tetromino = Tetromino()
tetromino.execute()
