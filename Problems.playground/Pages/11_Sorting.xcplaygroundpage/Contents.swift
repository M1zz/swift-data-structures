//: [← Trie](@previous) | [다음 →](@next)
/*: # Ch.11 — Sorting 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 색상 정렬 (Sort Colors / Dutch National Flag)
// 0, 1, 2만 들어있는 배열을 정렬하세요. O(n), 공간 O(1)
// 예: [2,0,2,1,1,0] → [0,0,1,1,2,2]
func sortColors(_ nums: inout [Int]) {
    // TODO: 삼방 분할(three-way partition), 포인터 3개
}
var sc = [2,0,2,1,1,0]; sortColors(&sc)
assert(sc == [0,0,1,1,2,2])
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 가장 큰 수 만들기 (Largest Number)
// 정수 배열로 만들 수 있는 가장 큰 수를 문자열로 반환하세요.
// 예: [3,30,34,5,9] → "9534330"
func largestNumber(_ nums: [Int]) -> String {
    // TODO: 커스텀 비교자로 정렬
    return ""
}
assert(largestNumber([3,30,34,5,9]) == "9534330")
assert(largestNumber([10,2]) == "210")
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 배열의 상대 순서 정렬 (Relative Sort Array)
// arr2의 순서를 기준으로 arr1을 정렬하세요. arr2에 없는 원소는 뒤에 오름차순
// 예: arr1=[2,3,1,3,2,4,3,3], arr2=[3,2] → [3,3,3,3,2,2,1,4]
func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    // TODO: 커스텀 정렬 기준 정의
    return []
}
assert(relativeSortArray([2,3,1,3,2,4,3,3], [3,2]) == [3,3,3,3,2,2,1,4])
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 병합 전 구간 정렬 (Merge Intervals)
// 겹치는 구간을 합쳐서 반환하세요.
// 예: [[1,3],[2,6],[8,10],[15,18]] → [[1,6],[8,10],[15,18]]
func merge(_ intervals: [[Int]]) -> [[Int]] {
    // TODO: 시작점 기준 정렬 후 순차 병합
    return []
}
assert(merge([[1,3],[2,6],[8,10],[15,18]]) == [[1,6],[8,10],[15,18]])
assert(merge([[1,4],[4,5]]) == [[1,5]])
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 역전 쌍 수 세기 (Count of Inversions)
// 배열에서 i < j 이지만 arr[i] > arr[j]인 쌍의 수를 O(n log n)으로 구하세요.
// 예: [7,3,2,6,1] → 8
func countInversions(_ arr: [Int]) -> Int {
    // TODO: Merge Sort에서 병합 단계에 역전 쌍 카운트 추가
    return 0
}
assert(countInversions([7,3,2,6,1]) == 8)
assert(countInversions([1,2,3,4,5]) == 0)
print("P5 통과 ✓")
