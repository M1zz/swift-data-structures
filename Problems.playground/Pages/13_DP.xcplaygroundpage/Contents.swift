//: [← BinarySearch](@previous) | [다음 →](@next)
/*: # Ch.13 — Dynamic Programming 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 집 도둑질 (House Robber)
// 인접한 집을 동시에 털 수 없을 때 훔칠 수 있는 최대 금액
// 예: [1,2,3,1] → 4,  [2,7,9,3,1] → 12
func rob(_ nums: [Int]) -> Int {
    // TODO: dp[i] = max(dp[i-1], dp[i-2]+nums[i])
    return 0
}
assert(rob([1,2,3,1]) == 4)
assert(rob([2,7,9,3,1]) == 12)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 최장 증가 부분수열 길이 (LIS)
// 예: [10,9,2,5,3,7,101,18] → 4  ([2,3,7,101])
// O(n log n) 목표
func lengthOfLIS(_ nums: [Int]) -> Int {
    // TODO: patience sorting / binary search
    return 0
}
assert(lengthOfLIS([10,9,2,5,3,7,101,18]) == 4)
assert(lengthOfLIS([0,1,0,3,2,3]) == 4)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 고유 경로 (Unique Paths)
// m×n 격자의 왼쪽 위에서 오른쪽 아래까지 이동하는 경우의 수 (오른쪽/아래만 가능)
// 예: m=3, n=7 → 28
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    // TODO: 2D DP 또는 1D rolling array
    return 0
}
assert(uniquePaths(3,7) == 28)
assert(uniquePaths(3,2) == 3)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 팰린드롬 부분 문자열 수 (Count Palindromic Substrings)
// 예: "abc" → 3,  "aaa" → 6
func countSubstrings(_ s: String) -> Int {
    // TODO: 중심 확장 또는 DP
    return 0
}
assert(countSubstrings("abc") == 3)
assert(countSubstrings("aaa") == 6)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P5. 0-1 배낭 문제 (0/1 Knapsack)
// weights, values, capacity가 주어질 때 최대 가치를 구하세요.
// 예: w=[1,2,3], v=[6,10,12], capacity=5 → 22
func knapsack(_ weights: [Int], _ values: [Int], _ capacity: Int) -> Int {
    // TODO: 2D DP 또는 1D rolling
    return 0
}
assert(knapsack([1,2,3], [6,10,12], 5) == 22)
print("P5 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P6. 버스트 풍선 (Burst Balloons - 구간 DP)
// 각 풍선을 터뜨릴 때 왼쪽, 자신, 오른쪽의 곱만큼 코인을 얻습니다. 최대 코인을 구하세요.
// 예: [3,1,5,8] → 167
func maxCoins(_ nums: [Int]) -> Int {
    // TODO: 구간 DP, dp[i][j] = 구간 (i,j) 내 최대 코인
    return 0
}
assert(maxCoins([3,1,5,8]) == 167)
assert(maxCoins([1,5]) == 10)
print("P6 통과 ✓")
