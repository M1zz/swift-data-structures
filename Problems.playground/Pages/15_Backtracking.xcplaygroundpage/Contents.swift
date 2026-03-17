//: [← Greedy](@previous) | [다음 →](@next)
/*: # Ch.15 — Backtracking 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 부분집합 (Subsets)
// 중복 없는 정수 배열의 모든 부분집합을 반환하세요.
// 예: [1,2,3] → [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
func subsets(_ nums: [Int]) -> [[Int]] {
    // TODO:
    return []
}
assert(Set(subsets([1,2,3]).map { $0.sorted() }.map { "\($0)" }).count == 8)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 순열 (Permutations)
// 예: [1,2,3] → [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
func permute(_ nums: [Int]) -> [[Int]] {
    // TODO:
    return []
}
assert(permute([1,2,3]).count == 6)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 팰린드롬 분할 (Palindrome Partitioning)
// 문자열을 팰린드롬만으로 분할하는 모든 방법을 반환하세요.
// 예: "aab" → [["a","a","b"],["aa","b"]]
func partition(_ s: String) -> [[String]] {
    // TODO:
    return []
}
assert(partition("aab").count == 2)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. N-Queens
// n×n 체스판에서 n개의 퀸이 서로 공격하지 않는 모든 배치를 반환하세요.
// n=4 → 2가지 해
func solveNQueens(_ n: Int) -> [[String]] {
    // TODO:
    return []
}
assert(solveNQueens(4).count == 2)
assert(solveNQueens(1).count == 1)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 표현식에 괄호 추가 (Different Ways to Add Parentheses)
// 연산자(+,-,*)가 있는 표현식에 괄호를 다르게 추가해 얻을 수 있는 모든 결과를 반환하세요.
// 예: "2-1-1" → [0, 2],  "2*3-4*5" → [-34,-14,-10,-10,10]
func diffWaysToCompute(_ expression: String) -> [Int] {
    // TODO: 분할 정복 + 메모이제이션
    return []
}
assert(Set(diffWaysToCompute("2-1-1")) == Set([0,2]))
print("P5 통과 ✓")
