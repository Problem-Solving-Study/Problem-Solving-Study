let t: Int = Int(readLine()!)!
var input: [Int]
var N: Int!
var M: Int!
var queue: [Int]!

for _ in 0..<t {
    input = readLine()!.split(separator: " ").map({ Int($0)! })
    N = input[0]
    M = input[1]
    queue = readLine()!.split(separator: " ").map({ Int($0)! })

    solution()
}

func solution() {
    var max: Int
    var start: Int = 0

    while start < N {
        max = queue.max()!

        if queue[start] == max {
            if start == M {
                print("\(start + 1)")
                return
            }

            queue[start] = -1
            start += 1
        } else {
            if start == M {
                M = queue.count - 1
            } else {
                M -= 1
            }

            queue.append(queue[start])
            queue.remove(at: start)
        }
    }
}
