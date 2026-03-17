//: [← 개념으로 돌아가기](@previous)
/*:
 # A3 실습 — Dynamic Programming
*/
import Foundation

// ── 실습 1: 계단 오르기 ──
// 한 번에 1칸 또는 2칸을 오를 수 있을 때, n번째 계단에 오르는 방법의 수를 구합니다.
// 점화식: f(n) = f(n-1) + f(n-2) → 피보나치와 동일한 구조
// 변수 두 개만으로 O(1) 공간에 해결합니다.
func climbStairs(_ n: Int) -> Int {
    guard n > 1 else { return n }
    var prev = 1  // f(1) = 1
    var curr = 2  // f(2) = 2
    // 3부터 n까지 반복 — 직전 두 값만 유지
    for _ in 3...n {
        let next = prev + curr
        prev = curr
        curr = next
    }
    return curr
}

print("계단 오르기:")
print(climbStairs(2))  // 2: (1,1), (2)
print(climbStairs(3))  // 3: (1,1,1), (1,2), (2,1)
print(climbStairs(5))  // 8

// ── 실습 2: 동전 거스름돈 (최소 동전 수) ──
// 동전 종류가 주어질 때, amount를 만드는 데 필요한 최소 동전 수를 구합니다.
// dp[i] = i원을 만드는 최소 동전 수
// 전이: dp[i] = min(dp[i - coin] + 1)  for each coin ≤ i
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    var dp = Array(repeating: amount + 1, count: amount + 1)
    dp[0] = 0  // 0원은 동전 0개로 만들 수 있다
    for i in 1...amount {
        for coin in coins {
            if coin <= i {
                // coin 하나를 추가했을 때 dp[i-coin]보다 줄어드는지 확인
                dp[i] = min(dp[i], dp[i - coin] + 1)
            }
        }
    }
    // amount + 1이 남아 있으면 만들 수 없는 금액
    return dp[amount] > amount ? -1 : dp[amount]
}

print("\n동전 거스름돈:")
print(coinChange([1, 5, 11], 15))   // 3: 5+5+5
print(coinChange([1, 2, 5], 11))    // 3: 5+5+1
print(coinChange([2], 3))           // -1: 불가능

// ── 실습 3: 최장 공통 부분수열 경로 복원 ──
// LCS 길이뿐 아니라 실제 공통 부분수열 문자열도 반환합니다.
// dp 테이블을 채운 뒤, (m, n)에서 시작해 역추적(backtrack)으로 경로를 복원합니다.
//   - a[i-1] == b[j-1] → 이 문자가 LCS에 포함 → 대각선 이동 후 결과에 추가
//   - dp[i-1][j] >= dp[i][j-1] → 위쪽으로 이동
//   - 아니면 → 왼쪽으로 이동
func lcsString(_ a: String, _ b: String) -> String {
    let a = Array(a), b = Array(b)
    let m = a.count, n = b.count
    // dp 테이블 채우기
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
    for i in 1...m { for j in 1...n {
        dp[i][j] = a[i-1] == b[j-1] ? dp[i-1][j-1] + 1 : max(dp[i-1][j], dp[i][j-1])
    }}
    // dp 테이블 역추적으로 LCS 문자열 복원
    var result: [Character] = []
    var i = m, j = n
    while i > 0 && j > 0 {
        if a[i-1] == b[j-1] {
            result.append(a[i-1])  // 공통 문자 → LCS에 포함
            i -= 1; j -= 1
        } else if dp[i-1][j] >= dp[i][j-1] {
            i -= 1  // 위쪽이 크거나 같으면 위로 이동
        } else {
            j -= 1  // 아니면 왼쪽으로 이동
        }
    }
    return String(result.reversed())  // 역순으로 쌓였으므로 뒤집어서 반환
}

print("\nLCS 문자열:")
print(lcsString("ABCBDAB", "BDCAB"))  // "BCAB" 또는 "BDAB" (길이 4)

// ── 실습 4: 편집 거리 (Edit Distance) ──
// word1을 word2로 바꾸는 데 필요한 최소 연산 수를 구합니다.
// 연산: insert / delete / replace (각 비용 1)
// dp[i][j] = word1[0..<i] → word2[0..<j] 의 최소 편집 거리
// 전이:
//   - 문자가 같으면: dp[i-1][j-1] (추가 비용 없음)
//   - 다르면: min(
//       dp[i-1][j]   + 1,  // word1에서 삭제
//       dp[i][j-1]   + 1,  // word2에 삽입
//       dp[i-1][j-1] + 1   // 교체
//     )
func minDistance(_ word1: String, _ word2: String) -> Int {
    let w1 = Array(word1), w2 = Array(word2)
    let m = w1.count, n = w2.count
    // 초기화: dp[i][0] = i (삭제 i번), dp[0][j] = j (삽입 j번)
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
    for i in 0...m { dp[i][0] = i }
    for j in 0...n { dp[0][j] = j }
    // 점화식 적용
    for i in 1...m {
        for j in 1...n {
            if w1[i-1] == w2[j-1] {
                dp[i][j] = dp[i-1][j-1]
            } else {
                dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
            }
        }
    }
    return dp[m][n]
}

print("\n편집 거리:")
print(minDistance("horse", "ros"))            // 3
print(minDistance("intention", "execution"))  // 5

/*:
 ## 도전 과제
 1. **집 도둑질(House Robber)**: 인접한 집을 동시에 털 수 없을 때 최대 금액
 2. **정규식 매칭**: `.`과 `*`를 포함한 패턴 매칭 DP
 3. **풍선 터뜨리기**: 구간 DP — 풍선을 터뜨릴 때 얻는 최대 코인

 [다음 → Greedy 개념](@next)
*/
