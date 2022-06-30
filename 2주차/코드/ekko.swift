import Foundation

struct MinHeap {
    var heap: [Int] = []
    
    var isEmpty: Bool {
        return heap.count <= 1 ? true : false
    }
    
    init() {}
    init(_ element: Int) {
        heap.append(element) // 0번 index채우기 용
        heap.append(element) // 실제 Root Node 채움.
    }
    
    mutating func insert(_ element: Int) {
        if heap.isEmpty {
            heap.append(element)
            heap.append(element)
            return
        }
        heap.append(element)
        
        func isMoveUp(_ insertIndex: Int) -> Bool {
            if insertIndex <= 1 { // Root Node일 때,
                return false
            }
            let parentIndex = insertIndex / 2
            return heap[insertIndex] < heap[parentIndex] ? true : false
        }
        
        var insertIndex = heap.count - 1
        while isMoveUp(insertIndex) {
            let parentIndex = insertIndex / 2
            heap.swapAt(insertIndex, parentIndex)
            insertIndex = parentIndex
        }
    }
    
    enum moveDownStatus { case left, right, none }
    
    mutating func pop() -> Int? {
        if heap.count <= 1 {
            return nil
        }
        let returnData = heap[1]
        heap.swapAt(1, heap.count - 1)
        heap.removeLast()
        
        func moveDown(_ poppedIndex: Int) -> moveDownStatus {
            let leftChildIndex = poppedIndex * 2
            let rightChildIndex = leftChildIndex + 1
            
            // case1. 모든 자식 노드가 없는 경우
            if leftChildIndex >= heap.count {
                return .none
            }
            
            // case2. 왼쪽 자식 노드만 있는 경우
            if rightChildIndex >= heap.count {
                return heap[leftChildIndex] < heap[poppedIndex] ? .left : .none
            }
            
            // case3. 왼쪽&오른쪽 자식 노드 모두 있는 경우
            // case3-1. 자식들이 자신보다 모두 큰 경우(자신이 제일 작은 경우)
            if (heap[leftChildIndex] > heap[poppedIndex]) && (heap[rightChildIndex] > heap[poppedIndex]) {
                return .none
            }
            
            // case3-2. 자식들이 자신보다 모두 작은 경우 (왼쪽과 오른쪽 자식 중, 더 작은 자식을 선별)
            if (heap[leftChildIndex] < heap[poppedIndex]) && (heap[rightChildIndex] < heap[poppedIndex]) {
                return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
            }
            
            // case3-3. 왼쪽과 오른쪽 자식 중, 한 자식만 자신보다 작은 경우
            return heap[leftChildIndex] < heap[rightChildIndex] ? .left : .right
        }
        
        var poppedIndex = 1
        while true {
            switch moveDown(poppedIndex) {
            case .none:
                return returnData
            case .left:
                let leftChildIndex = poppedIndex * 2
                heap.swapAt(poppedIndex, leftChildIndex)
                poppedIndex = leftChildIndex
            case .right:
                let rightChildIndex = (poppedIndex * 2) + 1
                heap.swapAt(poppedIndex, rightChildIndex)
                poppedIndex = rightChildIndex
            }
        }
    }
}

let n = Int(readLine()!)!
var minHeap: MinHeap = MinHeap()

for _ in 0 ..< n {
    let input = Int(readLine()!)!

    if input == 0 {
        print(minHeap.pop() ?? 0)
    }
    else {
        minHeap.insert(input)
    }
}