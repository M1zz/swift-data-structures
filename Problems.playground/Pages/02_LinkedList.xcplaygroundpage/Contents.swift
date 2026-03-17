//: [← Array](@previous) | [다음 →](@next)
/*: # Ch.02 — LinkedList 문제 */
import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, _ next: ListNode? = nil) { self.val = val; self.next = next }
}

// 헬퍼: 배열 → 연결 리스트
func makeList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    let dummy = ListNode(0)
    var cur = dummy
    for v in arr { cur.next = ListNode(v); cur = cur.next! }
    return dummy.next
}
// 헬퍼: 연결 리스트 → 배열
func toArray(_ head: ListNode?) -> [Int] {
    var res: [Int] = [], cur = head
    while let c = cur { res.append(c.val); cur = c.next }
    return res
}

// ─────────────────────────────────────────
// 🟢 P1. 연결 리스트 뒤집기 (Reverse Linked List)
// 예: 1→2→3→4→5 → 5→4→3→2→1
func reverseList(_ head: ListNode?) -> ListNode? {
    // TODO:
    return nil
}
assert(toArray(reverseList(makeList([1,2,3,4,5]))) == [5,4,3,2,1])
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 중간 노드 찾기 (Middle of the Linked List)
// 홀수 길이면 정중앙, 짝수 길이면 두 번째 중간 노드 반환
// 예: [1,2,3,4,5] → 3번 노드,  [1,2,3,4] → 3번 노드
// 힌트: slow/fast 포인터
func middleNode(_ head: ListNode?) -> ListNode? {
    // TODO:
    return nil
}
assert(toArray(middleNode(makeList([1,2,3,4,5]))) == [3,4,5])
assert(toArray(middleNode(makeList([1,2,3,4]))) == [3,4])
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 두 정렬 리스트 합치기 (Merge Two Sorted Lists)
// 예: [1,2,4] + [1,3,4] → [1,1,2,3,4,4]
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // TODO:
    return nil
}
assert(toArray(mergeTwoLists(makeList([1,2,4]), makeList([1,3,4]))) == [1,1,2,3,4,4])
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 연결 리스트에서 사이클 감지 (Linked List Cycle)
// 사이클이 있으면 true, 없으면 false
// 공간 복잡도 O(1) 목표 (Floyd's algorithm)
func hasCycle(_ head: ListNode?) -> Bool {
    // TODO:
    return false
}
// 테스트: 3→2→0→-4→(2로 연결)
let cycleNode = ListNode(3)
cycleNode.next = ListNode(2)
cycleNode.next!.next = ListNode(0)
cycleNode.next!.next!.next = ListNode(-4)
cycleNode.next!.next!.next!.next = cycleNode.next  // 사이클 생성
assert(hasCycle(cycleNode) == true)
assert(hasCycle(makeList([1,2])) == false)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. k개씩 그룹으로 뒤집기 (Reverse Nodes in k-Group)
// k개씩 묶어서 각 그룹을 역순으로 만드세요. 남은 노드 수가 k 미만이면 그대로 둡니다.
// 예: [1,2,3,4,5], k=2 → [2,1,4,3,5]
// 예: [1,2,3,4,5], k=3 → [3,2,1,4,5]
func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    // TODO:
    return nil
}
assert(toArray(reverseKGroup(makeList([1,2,3,4,5]), 2)) == [2,1,4,3,5])
assert(toArray(reverseKGroup(makeList([1,2,3,4,5]), 3)) == [3,2,1,4,5])
print("P5 통과 ✓")
