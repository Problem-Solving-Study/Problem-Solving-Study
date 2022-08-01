//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/08/01.
//

// FIFO
final class MazeQueue<T> {
    private var inArr: [T] = []
    private var outArr: [T] = []

    var peek: T? {
        inArr.first ?? outArr.last
    }

    var count: Int {
        inArr.count + outArr.count
    }

    func enqueue(_ info: T) {
        inArr.append(info)
    }

    func dequeue() -> T {
        if outArr.isEmpty {
            outArr = inArr.reversed()
            inArr.removeAll(keepingCapacity: true)
        }

        return outArr.popLast()!
    }
}

func escapeMaze() {
    var N: Int!
    var M: Int!
    var map: [[Bool]] = []
    let move: [(dx: Int, dy: Int)] = [(-1,0),(0,-1),(1,0),(0,1)]
    var countMap: [[Int]]!

    // 입력을 읽는 함수입니다.
    func readInput() {
        let input = readLine()!.split(separator: " ").map({ string in
            Int(string)!
        })
        N = input[0]
        M = input[1]
        countMap = Array(repeating: Array(repeating: Int.max, count: M), count: N)
        countMap[0][0] = 1
        for _ in 0..<N {
            var row: [Bool] = []
            readLine()!.map { char in
                if char == "0" {
                    row.append(false)
                } else {
                    row.append(true)
                }
            }
            map.append(row)
        }
    }

    // bfs 를 이용해서 맵을 탐색합니다.
    func bfs() -> Int {
        var queue: MazeQueue = MazeQueue<(x: Int, y:Int, count: Int)>()
        queue.enqueue((0, 0, 1))

        while queue.count != 0 {
            let current = queue.dequeue()
            for dxDy in move {
                let X: Int = current.x + dxDy.dx
                let Y: Int = current.y + dxDy.dy

                if canMove(x: X, y: Y, currentMoveCount: current.count + 1) {
                    if X == M - 1 && Y == N-1  {
                        return current.count + 1
                    }
                    countMap[Y][X] = current.count + 1
                    queue.enqueue((X,Y, current.count + 1))
                }
            }
        }
        return -1
    }

    // 다음 위치로 움직일 수 있는지 계산하는 함수
    func canMove(x: Int, y: Int, currentMoveCount: Int) -> Bool {
        return x < M && y < N && x >= 0 && y >= 0 && map[y][x] && countMap[y][x] > currentMoveCount
    }

    readInput()
    print(bfs())
}

escapeMaze()
