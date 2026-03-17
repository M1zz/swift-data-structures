//: [← Sorting](@previous) | [다음 →](@next)
/*: # Ch.12 — Binary Search 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 삽입 위치 탐색 (Search Insert Position)
// 정렬 배열에서 target의 위치 또는 삽입 위치를 O(log n)으로 반환하세요.
// 예: [1,3,5,6], target=5 → 2,  target=2 → 1
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    // TODO: Lower Bound
    return 0
}
assert(searchInsert([1,3,5,6], 5) == 2)
assert(searchInsert([1,3,5,6], 2) == 1)
assert(searchInsert([1,3,5,6], 7) == 4)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 범위 내 원소 개수 (Count in Range)
// 정렬 배열에서 [lo, hi] 범위에 속하는 원소의 수를 O(log n)으로 반환하세요.
func countInRange(_ nums: [Int], _ lo: Int, _ hi: Int) -> Int {
    // TODO: upperBound(hi) - lowerBound(lo)
    return 0
}
assert(countInRange([1,2,3,3,4,5,6], 3, 5) == 4)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 피크 원소 찾기 (Find Peak Element)
// nums[i] > nums[i-1] && nums[i] > nums[i+1]인 피크의 인덱스를 반환하세요.
// O(log n) 목표. 경계 밖은 -∞로 간주.
func findPeakElement(_ nums: [Int]) -> Int {
    // TODO:
    return 0
}
assert([1, 2].contains(findPeakElement([1,2,3,1])))  // 인덱스 2 또는 다른 peak
assert(findPeakElement([1,2,3,1]) == 2)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 최솟값 찾기 - 회전 정렬 배열 (Find Minimum in Rotated Sorted Array)
// 예: [3,4,5,1,2] → 1
func findMin(_ nums: [Int]) -> Int {
    // TODO: O(log n)
    return 0
}
assert(findMin([3,4,5,1,2]) == 1)
assert(findMin([4,5,6,7,0,1,2]) == 0)
assert(findMin([11,13,15,17]) == 11)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 나쁜 버전 찾기 - 파라메트릭 서치 (First Bad Version)
// isBadVersion(k) API가 주어질 때 첫 번째 나쁜 버전을 O(log n)으로 찾으세요.
// (테스트: 5개 버전 중 4번째가 bad)
var _badVersion = 4
func isBadVersion(_ v: Int) -> Bool { return v >= _badVersion }

func firstBadVersion(_ n: Int) -> Int {
    // TODO:
    return -1
}
assert(firstBadVersion(5) == 4)
_badVersion = 1
assert(firstBadVersion(1) == 1)
print("P5 통과 ✓")
