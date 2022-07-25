func 소수찾기() {
    let N: Int = Int(readLine()!)!
    let nums: [Int] = readLine()!.split(separator: " ").map { Int($0)! }

    var numberOfPrimeNum: Int = 0

    for i in 0..<N {
        if isPrimeNum(num: nums[i]) {
            numberOfPrimeNum += 1
        }
    }
    
    print("\(numberOfPrimeNum)")

    func isPrimeNum(num: Int) -> Bool {
        if num == 1 {
            return false
        }

        var isDivided: [Bool] = [Bool](repeating: false, count: num)
        var divider: Int

        for i in 2..<num {
            if isDivided[i] {
                return false
            }

            if num % i == 0 {
                isDivided[i] = true
                divider = i

                while divider < num {
                    if !isDivided[divider] {
                        isDivided[divider] = true
                    }
                    divider += i
                }
                return false
            }
        }

        return true
    }
}

소수찾기()
