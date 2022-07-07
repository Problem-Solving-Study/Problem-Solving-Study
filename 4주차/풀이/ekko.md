### Solution 1)
기본적으로 Queue는 FIFO(First In First Out)의 형태를 띈다.
하지만 여기서는 우선순위라는 개념이 적용되어야 한다.

큐 내부의 배열에서 
`맨 처음`부터 탐색하여 우선순위가 높은 순서부터 다시 배출하는 것이다.

- 기본틀
```swift
struct Queue {
	// 처음 요소의 위치와 중요도를 저장해야 하므로 튜플로 구성 (처음 위치, 중요도)
	var queue: [(Int, Int)] = []
	
	// 큐에서 인덱스로 사용
	var index = 0 // 맨 처음부터 시작


	// 큐의 dequeue()를 실제로 구현하려면 시간복잡도를 위해서 더블 스택으로 구현하거나 해야 하기 때문에
	// 진짜 큐를 구현하는게 아니라 시작점을 계속 이동하는 식으로 구현
	var count: Int {
		return queue.count - index
	}
}
```

- 현재 요소를 출력할 수 있는지 확인
```swift
var isPrintable: Bool {
	// 요소가 한 개면 바로 출력
	if queue.count == 1 { return true }

	// 하나씩 탐색
	for i in (index + 1) ..< queue.count {
		// 중요도가 더 높은 녀석이 있으면 출력하지 않는다.
		if queue[i].1 > queue[index].1 { return false }
	}
	return true
}
```

큐의 시작점을 계속 이동하기 때문에
여기서 큐의 시작점은 `queue[index]` 이다.


- enqueue()
```swift
mutating func enqueue(_ tuple: (Int, Int)) {
	queue.append(tuple)
}
```

배열의 append() 메서드를 활용해서 추가해준다.

- dequeue()
```swift
mutating func dequeue() -> (Int, Int) {
	defer {
		index += 1
	}
	return queue[index]
}
```

여기서 dequeue()는 실제 queue 배열에서 방출하는게 아니라 방출한 것처럼 보이게 하는 것이다.
그래서 배열의 시작점을 이동시키는 것이 중요하다.
즉, 현재 처음 요소를 방출하고, index값을 바꿔주는 것.

- 솔루션
```swift
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
```

테스트 케이스 만큼 반복하고
주어지는 배열을 큐로 만들고, 타겟 넘버를 찾을 때까지 무한 반복.
그 때까지 걸리는 횟수를 구하는 것이기 때문에 `cnt`변수 설정
프린트가 가능하면 dequeue()하고, cnt의 횟수를 추가하고, 그 값이 타겟 넘버와 맞으면 실행을 중단하고, 아니면 이 과정을 반복한다.
프린트가 불가능하면 방출하지 못했으므로 뒤로 보낸다.



### Solution 2)
기본적으로 위의 방법과 유사하다.

```swift
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

```
이번에는 값을 배열에서 빼버리는 것이다.