import Foundation

// SOL 1)
struct Queue {
    // index 큐를 사용 (N이 적으므로)
    var queue = [(Int, Int)]() // 처음 문서 위치를 기억해야하므로 (처음 위치, 중요도)의 튜플
    var index = 0
    
    // 입력을 받아서 튜플의 배열로 바꾸어 저장한다.
    init(_ array: Array<Int>) {
        for (i, num) in array.enumerated() {
            queue.append((i, num))
        }
    }
    
    var count: Int {
        return queue.count - index
    }
    
    // 현재 맨 앞의 문서를 출력할 수 있는지
        //index를 queue일 경우 처음 문서는 queue[index]라는 점에 주의
    var isPrintable: Bool {
        if queue.count == 1 { return true } // 문서가 1개 뿐이면 true
        for i in (index + 1) ..< queue.count { // 순차 탐색을 하면서
            if queue[i].1 > queue[index].1 { return false } // 더 중요한 문서가 있으면 false
        }
        return true
    }
    
    mutating func enqueue(_ tuple: (Int, Int)) {
        queue.append(tuple)
    }
    
    mutating func dequeue() -> (Int, Int) {
        defer {
            index += 1
        }
        return queue[index]
    }
}

let T = Int(readLine()!)!

// 테스트 케이스 만큼 반복
for _ in 0..<T {
    let input1 = readLine()!.split(separator: " ").map { Int(String($0))! }
    let M = input1[1] // 추적하고자 하는 문서 위치
    let input2 = readLine()!.split(separator: " ").map { Int(String($0))! }
    var queue = Queue(input2)
    var cnt = 0 // 현재까지 출력된 문서 갯수
    while true {
        // 프린트가 가능하면
        if queue.isPrintable {
            let printed = queue.dequeue() // 프린트하고
            cnt += 1 // 갯수 추가
            if printed.0 == M { break } // 추적하는 문서인지 확인
        // 프린트 안되면
        } else {
            queue.push(queue.dequeue()) // 맨 뒤로 보내기
        }
    }
    print(cnt)
}



// SOL 2)
let t = Int(readLine()!)!

for _ in 1...t {
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }
    let m = inputs[1]
    
    // 몇번째 출력되는지
    var cnt = 0
    
    // input array -> 중요도가 담겨있음.
    var inputArray = readLine()!.split(separator: " ").map{ Int($0)! }
    
    // (인덱스, 중요도)를 담을 배열
    var priorityList: [(Int, Int)] = []
    
    // input array에서 index와 중요도를 tuple로 만들어서
    for (index, priority) in inputArray.enumerated() {
        let tuple = (priority, index)
        // priorityList에 추가
        priorityList.append(tuple)
    }
    
    // 중요도 순으로 오름차순
    inputArray.sort()
    
    while true {
        // priorityList 배열 맨 앞부터 비교해서 중요도가 제일 높으면
        if priorityList[0].0 == inputArray.max() {
            // 카운터를 1 올리고
            cnt += 1
            
            // 맨앞 녀석의 인덱스가 타겟 인덱스가 맞다면
            if priorityList[0].1 == m {
                // 카운터 출력
                print(cnt)
                break
                
            // 타겟과 다르면
            } else {
                // 맨처음 녀석 빼버린다.
                priorityList.removeFirst()
                // 가장 중요한 녀석 빼기
                inputArray.popLast()
            }
        // 중요도가 제일 높지 않으면
        } else {
            // priorityList 배열에 맨 앞에 녀석을 다시 뒤에 추가
            priorityList.append(priorityList.removeFirst())
        }
    }
}
