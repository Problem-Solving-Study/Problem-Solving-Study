func 설탕배달() {
    let N: Int = Int(readLine()!)!
    let remainder: Int = N % 5
    var result: Int = N / 5

    if remainder % 3 == 0 {
        result += remainder / 3
    } else if remainder % 3 == 1 && result > 0 {
        result = result + (remainder + 5) / 3 - 1
    } else if remainder % 3 == 2 && result > 1 {
        result = result + (remainder + 10) / 3 - 2
    } else {
        result = -1
    }

    print("\(result)")
}

설탕배달()
