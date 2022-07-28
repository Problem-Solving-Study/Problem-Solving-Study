//
//  마인크래프트.swift
//  Algorithm
//
//  Created by 정재윤 on 2022/07/28.
//

import Foundation

/// 첫째 줄에 N, M, B가 주어진다. (1 ≤ M, N ≤ 500, 0 ≤ B ≤ 6.4 × 107)
/// 둘째 줄부터 N개의 줄에 각각 M개의 정수로 땅의 높이가 주어진다. (i + 2)번째 줄의 (j + 1)번째 수는 좌표 (i, j)에서의 땅의 높이를 나타낸다. 땅의 높이는 256보다 작거나 같은 자연수 또는 0이다.
///
/// 첫째 줄에 땅을 고르는 데 걸리는 시간과 땅의 높이를 출력하시오. 답이 여러 개 있다면 그중에서 땅의 높이가 가장 높은 것을 출력하시오.
///
/// 위에꺼 제거하면 2초
/// 채워넣으면 1초
/// 위에 있는거 개수 : 위에 없는거 개수 = 1 : 2 까지 가능, 여러가지가 있다면 채우는 쪽으로 할 것
/// 인벤토리의 블록개수를 파악하는 것도 중요함
///
/// 1. 땅에서 돌출부위가 몇인지 파악할 것 = 배열에서 max
/// 2. max와 같은거 몇개인지 확인
/// 3. 전체 블록 개수 중에 1/3의 비율보다 적으면 쳐내고
/// 4. 1/3비율보다 같거나 많으면 채워넣는다.
/// 5. 하지만 채워넣기 전에 밑으로 구멍이 더 많이 날 수도 있음. 그렇기 때문에 위에 돌출된 녀석의 개수와 비교해야 됨.


// 높이를 0부터 문제조건에 있는 256까지 모두 탐색을 하며 가능한 여부인지 확인
func 마인크래프트() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0]
    let m = input[1]
    let b = input[2]
    
    var graph: [[Int]] = Array(repeating: [], count: n)
    
    for i in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph[i] = input
    }
    
    var ansTime = Int.max;
    var ansHeight = -1;
    
    for h in 0 ... 256 {
        var inventory = 0;
        var removeCnt = 0;
        
        for i in 0 ..< n {
            for j in 0 ..< m {
                let curh = graph[i][j] - h;
                
                // 현재칸의 높이에서 현재 설정한 높이(h)를 뺀 값이 음수인 경우
                if curh < 0 {
                    // 더 높은 높이로 만들어야 한다. 따라서 inventory에 추가해준다 (curh가 음수이기 때문에 -=연산자를 사용해야 inventory값은 양수가 된다.)
                    inventory -= curh
                    //현재칸의 높이에서 현재 설정한 높이(h)를 뺀 값이 양수인 경우
                } else {
                    // 더 낮은 높이로 만들어야 한다. 따라서 블록을 제거해야 하므로 removeCnt를 차이(curh)만큼 더해준다.
                    removeCnt += curh
                }
            }
        }
        
        // 제거한 블록인 removeCnt와 원래 가지고 있던 블록인 b의 합이 추가를 해야하는 연산수인 inventory 값 보다 크거나 같으면 만들 수 있는 경우이다. 대소비교하여 값을 갱신해준다.
        if (removeCnt + b >= inventory) {
            let time = 2 * removeCnt + inventory;
            if ansTime >= time {
                ansTime = time;
                ansHeight = h;
            }
        }
    }
    
    print(ansTime, ansHeight)
}

