//: [← BST](@previous) | [다음 →](@next)
/*: # Ch.07 — Heap 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. K번째로 큰 원소 (Kth Largest Element)
// 정렬 없이 O(n log k)로 구하세요. (크기 k의 Min Heap 활용)
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    // TODO:
    return -1
}
assert(findKthLargest([3,2,1,5,6,4], 2) == 5)
assert(findKthLargest([3,2,3,1,2,4,5,5,6], 4) == 4)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. K개의 가장 빈번한 원소 (Top K Frequent Elements)
// 예: [1,1,1,2,2,3], k=2 → [1,2]
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    // TODO:
    return []
}
assert(Set(topKFrequent([1,1,1,2,2,3], 2)) == Set([1,2]))
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 배열을 K번 조작해 합 최솟값 (Minimum Cost to Connect Sticks)
// 막대를 연결할 때마다 두 막대의 합만큼 비용이 들 때, 하나로 연결하는 최소 비용
// 예: [1,2,3] → 9  (1+2=3, 3+3=6, 합=9)
// 힌트: Min Heap
func connectSticks(_ sticks: [Int]) -> Int {
    // TODO:
    return 0
}
assert(connectSticks([1,2,3]) == 9)
assert(connectSticks([1,8,3,5]) == 30)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 중간값 스트림 (Find Median from Data Stream)
// 데이터가 스트림으로 들어올 때 매번 중간값을 O(log n)에 반환하세요.
// 힌트: Max Heap (왼쪽) + Min Heap (오른쪽) 두 개 사용
class MedianFinder {
    // TODO:
    func addNum(_ num: Int) { /* TODO */ }
    func findMedian() -> Double { /* TODO */ return 0.0 }
}
let mf = MedianFinder()
mf.addNum(1); mf.addNum(2)
assert(mf.findMedian() == 1.5)
mf.addNum(3)
assert(mf.findMedian() == 2.0)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. K개 정렬 리스트 병합 (Merge K Sorted Lists)
class ListNode { var val: Int; var next: ListNode?; init(_ v: Int, _ n: ListNode? = nil){ val=v; next=n } }
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    // TODO: Min Heap 활용
    return nil
}
func makeList(_ a: [Int]) -> ListNode? { a.reversed().reduce(nil) { ListNode($1, $0) } }
func toArr(_ h: ListNode?) -> [Int] { var r=[Int](); var c=h; while let x=c { r.append(x.val); c=x.next }; return r }
let merged = mergeKLists([makeList([1,4,5]), makeList([1,3,4]), makeList([2,6])])
assert(toArr(merged) == [1,1,2,3,4,4,5,6])
print("P5 통과 ✓")
