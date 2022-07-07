//
//  main.swift
//  Algorithm
//
//  Created by JongHo Park on 2022/07/07.
//

import Foundation

class Queue<T> {
    var outSet: [T] = []
    var inSet: [T] = []
    var isEmpty: Bool {
        outSet.isEmpty && inSet.isEmpty
    }

    var peek: T? {
        outSet.last ?? inSet.first
    }

    func poll() -> T {
        if outSet.isEmpty {
            outSet = inSet.reversed()
            inSet.removeAll()
        }

        guard !outSet.isEmpty else {
            fatalError("queue should not empty")
        }
        return outSet.removeLast()
    }

    func insert(_ element: T) {
        inSet.append(element)
    }
}

typealias Printer = (weight: Int, index: Int)

func printerQueue() {
    let T = Int(readLine()!)!
    var output: String = ""
    for _ in 0..<T {
        let queue: Queue<Printer> = Queue()
        var weightArray: [Int] = Array(repeating: 0, count: 10)
        let input = readLine()!.components(separatedBy: " ").map { string in
            Int(string)!
        }
        let N = input[0]
        let M = input[1]

        let secondLine = readLine()!.components(separatedBy: " ").map { string in
            Int(string)!
        }
        for i in 0..<N {
            weightArray[secondLine[i]] += 1
            queue.insert((secondLine[i], i))
        }
        var count = 1
        while !queue.isEmpty {
            if !isExist(queue.peek!.weight, weightArray: weightArray) {
                weightArray[queue.peek!.weight] -= 1
                let thisIndex = queue.poll().index
                if  thisIndex == M {
                    output.append("\(count)\n")
                    break
                }
                count += 1
            } else {
                queue.insert(queue.poll())
            }
        }
    }

    print(output)
}

func isExist(_ weight: Int, weightArray: [Int]) -> Bool {
    if weight == 9 {
        return false
    }
    for i in (weight+1)...9 {
        if weightArray[i] > 0 {
            return true
        }
    }
    return false
}

printerQueue()
