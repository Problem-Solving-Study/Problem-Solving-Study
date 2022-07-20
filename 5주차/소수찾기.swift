// 첫 줄에 수의 개수 N이 주어진다. N은 100이하이다. 다음으로 N개의 수가 주어지는데 수는 1,000 이하의 자연수이다.
// 1,000,000,000 O(N^2) 까지 가능
// 소수의 개수 찾기

// 4
// 1 3 5 7

let n = Int(readLine()!)!
let nums = readLine()!.split(separator: " ").map { Int($0)! }

var count = 0
for num in nums {
  // 소수인지 아닌지를 확인할 flag
  var flag = true

  // 자연수가 들어오므로 1은 무시
  if num == 1 {
    continue
    // 2와 3도 미리 걸러낸다.
  } else if num < 4 {
    count += 1
    continue
  } 

  // 반복문의 길이를 줄이기 위해서 위의 작업을 수행한 것 (절반만 확인하면 소수 판별 가능)
  for i in 2 ... num / 2 {
    // 소수가 아닐 때
    if num % i == 0 {
      flag = false
      break
    }
  }

  // flag가 true면 소수라는 뜻 -> count +1 해주기
  if flag {
    count += 1
  }
}
print(count)



