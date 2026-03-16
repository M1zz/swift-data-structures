//: [← Back to Concepts](@previous)
/*:
 # A3 실습 — Dynamic Programming
*/
import Foundation

// ── Exercise 1: 계단 오르기 ──
// 한 번에 1칸 또는 2칸을 오를 수 있을 때, n번째 계단에 오르는 방법의 수를 구하세요.
func climbStairs(_ n: Int) -> Int {
    // TODO: DP로 implement. O(n) 시간, O(1) 공간
    return -1
}

print("Climb stairs:")
print(climbStairs(2))  // 2: (1,1), (2)
print(climbStairs(3))  // 3: (1,1,1), (1,2), (2,1)
print(climbStairs(5))  // 8

// ── Exercise 2: 동전 거스름돈 (최소 동전 수) ──
// 동전 종류가 주어질 때, amount를 만드는 데 필요한 최소 동전 수를 구하세요.
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    // TODO: Bottom-up DP로 implement.
    // dp[i] = i원을 만드는 최소 동전 수
    // dp[0] = 0, 나머지는 Int.max (불가능)
    return -1
}

print("\nCoin change:")
print(coinChange([1, 5, 11], 15))   // 3: 11+1+1+1+1? 아니면 5+5+5=3
print(coinChange([1, 2, 5], 11))    // 3: 5+5+1
print(coinChange([2], 3))           // -1: 불가능

// ── Exercise 3: 최장 공통 부분수열 경로 복원 ──
// LCS 길이뿐 아니라 실제 공통 부분수열 문자열도 반환하세요.
func lcsString(_ a: String, _ b: String) -> String {
    let a = Array(a), b = Array(b)
    let m = a.count, n = b.count
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
    for i in 1...m { for j in 1...n {
        dp[i][j] = a[i-1] == b[j-1] ? dp[i-1][j-1] + 1 : max(dp[i-1][j], dp[i][j-1])
    }}
    // TODO: dp 테이블을 역추적하여 실제 LCS 문자열을 반환하세요.
    return ""
}

print("\nLCS string:")
print(lcsString("ABCBDAB", "BDCAB"))  // "BCAB" 또는 "BDAB" 등

// ── Exercise 4: 편집 거리 (Edit Distance) ──
// word1을 word2로 바꾸는 데 필요한 최소 연산 수를 구하세요.
// 연산: insert / delete / replace (각 비용 1)
func minDistance(_ word1: String, _ word2: String) -> Int {
    // TODO: O(m*n) DP로 implement.
    return -1
}

print("\nEdit distance:")
print(minDistance("horse", "ros"))      // 3
print(minDistance("intention", "execution"))  // 5

/*:
 ## Challenges
 1. **집 도둑질(House Robber)**: 인접한 집을 동시에 털 수 없을 때 최대 금액
 2. **정규식 매칭**: `.`과 `*`를 포함한 패턴 매칭 DP
 3. **풍선 터뜨리기**: 구간 DP — 풍선을 터뜨릴 때 얻는 최대 코인

 [다음 → Greedy 개념](@next)
*/
