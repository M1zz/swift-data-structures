//: [← Binary Search 실습](@previous)
/*:
 # A3 — Dynamic Programming

 ## 핵심 조건

 1. **optimal substructure**: 큰 문제의 최적해 = 작은 문제들의 최적해 조합
 2. **overlapping subproblems**: 같은 하위 문제가 여러 번 반복

 두 조건이 모두 성립할 때 DP를 적용합니다.

 ## Top-down vs Bottom-up

 | | Top-down (Memoization) | Bottom-up (Tabulation) |
 |--|--|--|
 | 구현 | 재귀 + 캐시 | 반복문 + 테이블 |
 | 직관성 | 높음 | 낮음 |
 | 스택 오버플로우 | 주의 | 없음 |
 | 공간 최적화 | 어려움 | 쉬움 |

 ## 주요 DP 유형

 - **1D**: 계단 오르기, 동전 거스름돈, 집 도둑질
 - **2D**: LCS, 0-1 Knapsack, 편집 거리
 - **구간 DP**: 풍선 터뜨리기, 행렬 연쇄 곱셈
 - **LIS**: 이분 탐색으로 O(n log n)

 ## In Practice?
 - **자동 줄바꿈**: 단어를 최적 배치하는 DP
 - **diff 알고리즘**: LCS 기반으로 변경 사항 계산 (git diff, UITableView diff)
 - **자연어 처리**: Viterbi 알고리즘 (HMM)
*/
import Foundation

// ── 피보나치: 재귀 → Memoization → Tabulation ──
// 1) 재귀 (지수 복잡도 O(2^n))
func fibNaive(_ n: Int) -> Int {
    if n <= 1 { return n }
    return fibNaive(n-1) + fibNaive(n-2)
}

// 2) Memoization (O(n))
var memo = [Int: Int]()
func fibMemo(_ n: Int) -> Int {
    if n <= 1 { return n }
    if let v = memo[n] { return v }
    let result = fibMemo(n-1) + fibMemo(n-2)
    memo[n] = result
    return result
}

// 3) Tabulation (O(n), O(1) 공간)
func fibDP(_ n: Int) -> Int {
    if n <= 1 { return n }
    var a = 0, b = 1
    for _ in 2...n { (a, b) = (b, a + b) }
    return b
}

print("fib(10): naive=\(fibNaive(10)), memo=\(fibMemo(10)), dp=\(fibDP(10))")

// ── LCS (Longest Common Subsequence) ──
func lcs(_ a: String, _ b: String) -> Int {
    let a = Array(a), b = Array(b)
    let m = a.count, n = b.count
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
    for i in 1...m { for j in 1...n {
        dp[i][j] = a[i-1] == b[j-1]
            ? dp[i-1][j-1] + 1
            : max(dp[i-1][j], dp[i][j-1])
    }}
    return dp[m][n]
}

print("LCS(\"ABCBDAB\", \"BDCAB\"): \(lcs("ABCBDAB", "BDCAB"))")  // 4

// ── LIS O(n log n) ──
func lis(_ nums: [Int]) -> Int {
    var tails = [Int]()
    for n in nums {
        var lo = 0, hi = tails.count
        while lo < hi {
            let mid = lo + (hi - lo) / 2
            if tails[mid] < n { lo = mid + 1 } else { hi = mid }
        }
        if lo == tails.count { tails.append(n) } else { tails[lo] = n }
    }
    return tails.count
}

print("LIS([10,9,2,5,3,7,101,18]): \(lis([10,9,2,5,3,7,101,18]))")  // 4

// ── 0-1 Knapsack (1D 최적화) ──
func knapsack(capacity W: Int, weights: [Int], values: [Int]) -> Int {
    var dp = Array(repeating: 0, count: W + 1)
    for i in 0..<weights.count {
        // 역순 순회: 같은 아이템 중복 사용 방지
        for w in stride(from: W, through: weights[i], by: -1) {
            dp[w] = max(dp[w], dp[w - weights[i]] + values[i])
        }
    }
    return dp[W]
}

let result = knapsack(capacity: 50,
                      weights: [10, 20, 30],
                      values:  [60, 100, 120])
print("Knapsack: \(result)")  // 220

/*:
 [Next → Practice](@next)
*/
