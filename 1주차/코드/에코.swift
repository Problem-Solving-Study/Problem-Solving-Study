let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = input[0]
let m = input[1]

var graph : [[Int]] = Array(repeating: [], count: n + 1)

for _ in 1 ... m {
    let nodes = readLine()!.split(separator: " ").map { Int(String($0))! } 
    graph[nodes[1]] += [nodes[0]]
}

var results = [0]
for i in 1 ... n {
  let count = dfs(graph, i) 
  results.append(count)
}

var answer = ""
for i in 0 ..< n {
  if results[i] == results.max() {
    answer += "\(i) "
  }
}

print(answer)

func dfs(_ graph: [[Int]], _ start: Int) -> Int {
    var visitedQueue = [Int]()
    var needVisitStack: [Int] = [start]

    var count = 1
    while !needVisitStack.isEmpty {
        count += 1
        let node = needVisitStack.removeLast()
        if visitedQueue.contains(node) { continue }
        
        visitedQueue.append(node)
        needVisitStack += graph[node]
    }
    
    return count
}