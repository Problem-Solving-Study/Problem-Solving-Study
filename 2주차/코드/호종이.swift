//
//  Generic.swift
//  SwiftUIPlayground
//
//  Created by JongHo Park on 2022/06/22.
//

import Foundation


final class Heap<Element> {
  typealias Compare = (Element, Element) -> Bool
  private var heap: [Element]

  private let compare: Compare

  init(_ compare: @escaping Compare) {
    self.compare = compare
    heap = []
  }

  var count: Int {
    return heap.count
  }
  var front: Element? {
    return heap.first
  }

  func pop() -> Element {
    // 먼저 제일 위에 있는 원소를 빼낸다
    guard !heap.isEmpty else {
      fatalError("heap is empty")
    }
    heap.swapAt(0, heap.count - 1)
    let ret = heap.removeLast()
    // 자식들을 보면서 자기보다 작으면, 위치를 교환한다. (제일 아래 leaf 가 나올 때까지)
    shiftDown(0)
    return ret
  }

  func add(_ element: Element) {
    heap.append(element)
    shiftUp(heap.count - 1)
  }

  func isEmpty() -> Bool {
    return heap.isEmpty
  }

  private func leftChid(of index: Int) -> Int {
    return index * 2 + 1
  }
  private func rightChild(of index: Int) -> Int {
    return index * 2 + 2
  }

  private func parent(of index: Int) -> Int {
    return (index - 1) / 2
  }

  private func shiftUp(_ index: Int) {
    var current = index
    // 부모 노드가 존재하고, 나보다 클 때 까지 계속해서 swap 한다.
    while parent(of: current) >= 0 && compare(heap[current], heap[parent(of: current)]) {
      heap.swapAt(current, parent(of: current))
      current = parent(of: current)
    }
  }

  private func shiftDown(_ index: Int) {
    var current = index
    // 자식이 존재하지 않을 때 까지 반복한다.
    while leftChid(of: current) < heap.count {
      // 왼쪽 자식 노드와, 오른쪽 자식 노드를 살펴본다.
      let leftChildIndex = leftChid(of: current)
      let rightChildIndex = rightChild(of: current)

      let left: Element = heap[leftChildIndex]
      let right: Element? = heap.count > rightChildIndex ? heap[rightChildIndex] : nil
      // 왼쪽 자식이 더 큰지 비교한다.
      let isLeftBigger: Bool = {
        if let right = right {
          return compare(left, right)
        }
        return true
      }()
      // 왼쪽 자식과 오른쪽 자식 중 왼쪽이 더 크고, 부모보다 더 크다면 swap 한다.
      if isLeftBigger && compare(left, heap[current]) {
        heap.swapAt(current, leftChildIndex)
        current = leftChildIndex
      }
      // 왼쪽 자식과 오른쪽 자식 중 오른쪽 자식이 더 크고, 부모보다 더 크다면 swap 한다.
      else if !isLeftBigger && compare(right!, heap[current]) {
        heap.swapAt(current, rightChildIndex)
        current = rightChildIndex
      }
      // 왼쪽과 오른쪽 자식 모두 부모보다 작다면, while 문 탈출
      else {
        break
      }
    }
  }
}

let N: Int! = Int(readLine()!)
var output: String = ""
let heap: Heap<Int> = Heap {
  $0 < $1
}
for _ in 1...N {
  let input: Int! = Int(readLine()!)
  if input == 0 {
    if !heap.isEmpty() {
      output += "\(heap.pop())\n"
    } else {
      output += "0\n"
    }
  } else {
    heap.add(input)
  }
}

print(output)



