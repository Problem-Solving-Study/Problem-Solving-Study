//
//  단지번호찾기.swift
//  Algorithm
//
//  Created by 정재윤 on 2022/07/28.
//

import Foundation

// 정사각형이므로 가로와 세로의 크기는 같으며 (5≤N≤25)

func 단지번호붙이기() {
    let n = Int(readLine()!)!
    var graph: [[Int]] = []
    for _ in 0 ..< n {
        let rows = readLine()!
        var arr: [Int] = []
        for s in rows {
            arr.append(Int(String(s))!)
        }
        graph.append(arr)
    }
    
    var cnt = 0
    
    @discardableResult
    func dfs(_ x: Int, _ y: Int) -> Bool {
        // 범위를 벗어나면 false
        if x <= -1 || y <= -1 || x >= n || y >= n { return false }
        
        // 1이면 카운팅 처리해줘야 한다.
        if graph[x][y] == 1 {
            // 일단 한 번 방문한 곳이니까 바꿔주고
            graph[x][y] = 0
            // 상하좌우로 다시 dfs 해줌
            dfs(x, y-1)
            dfs(x, y+1)
            dfs(x-1, y)
            dfs(x+1, y)
            
            // 집의 개수 +1
            cnt += 1
            
            // 어쨌거나 true
            return true
        }
        
        return false
    }
    
    var result = 0
    var arr: [Int] = []
    for i in 0 ..< n {
        for j in 0 ..< n {
            if dfs(i, j) {
                arr.append(cnt)
                cnt = 0
                result += 1
            }
        }
    }
    // 단지의 개수
    print(result)
    for a in arr {
        // 단지내 집의 수 오름차순 출력
        print(a)
    }
}

