//: > **Tip**: Xcode 메뉴에서 **Editor → Show Rendered Markup** 을 켜면 마크업이 렌더링되어 더 읽기 쉽습니다.
/*:
 # Ch.02 — Linked List

 ## 핵심 개념: 노드와 포인터

 Linked List는 **노드(Node)**들이 **포인터(참조)**로 연결된 자료구조입니다.
 각 노드는 **값(value)**과 **다음 노드를 가리키는 참조(next)**를 갖습니다.

 ```
 head → [10|→] → [20|→] → [30|nil]   ← tail
 ```

 배열과 달리 메모리에 연속으로 저장되지 않으므로,
 **맨 앞 삽입/삭제가 O(1)**이지만 **인덱스 접근은 O(n)**입니다.

 ## Array vs LinkedList

 **Array vs LinkedList 비교**
 - **인덱스 접근 [i]**: Array O(1) / LinkedList O(n)
 - **맨 앞 삽입**: Array O(n) / LinkedList **O(1)**
 - **맨 뒤 삽입**: Array O(1)* / LinkedList O(1) (tail 유지 시)
 - **중간 삽입 (노드 참조 시)**: Array O(n) / LinkedList **O(1)**
 - **메모리**: Array 연속 블록 / LinkedList 분산 (노드마다 할당)

 ## 시간복잡도

 **시간복잡도**
 - **prepend()**: O(1) — head 교체
 - **append()**: O(1) — tail 참조 유지 시
 - **removeFirst()**: O(1) — head 이동
 - **node(at:)**: O(n) — 순차 탐색
 - **insert(after:)**: O(1) — 노드 참조가 있으면

 ## 실무에서는?
 - **Undo/Redo**: 각 작업을 노드로 연결해 이전/다음 이동
 - **LRU 캐시**: 이중 연결 리스트 + Dictionary 조합
 - **음악 플레이어**: 이전곡/다음곡 이동 (이중 연결 리스트)
*/
import Foundation

// ── 노드 정의 ──
final class Node<T>: CustomStringConvertible {
    var value: T
    var next: Node<T>?
    init(_ value: T) { self.value = value }
    var description: String { "\(value)" }
}

// ── 간단한 연결 리스트 구축 및 순회 ──
let head = Node(10)
head.next = Node(20)
head.next?.next = Node(30)

print("=== 연결 리스트 순회 ===")
var current: Node<Int>? = head
var elements: [String] = []
while let node = current {
    elements.append("\(node.value)")
    current = node.next
}
print(elements.joined(separator: " → "))
// 출력: 10 → 20 → 30

// ── prepend O(1) 시연 ──
let newHead = Node(5)
newHead.next = head

print("\nprepend(5) 후:")
current = newHead
elements = []
while let node = current {
    elements.append("\(node.value)")
    current = node.next
}
print(elements.joined(separator: " → "))
// 출력: 5 → 10 → 20 → 30

// ── Array prepend vs LinkedList prepend 성능 비교 ──
print("\n=== 성능 비교: 맨 앞 삽입 ===")
let n = 30_000

let t1 = CFAbsoluteTimeGetCurrent()
var arr: [Int] = []
for i in 0..<n { arr.insert(i, at: 0) }
let arrTime = CFAbsoluteTimeGetCurrent() - t1

let t2 = CFAbsoluteTimeGetCurrent()
var llHead: Node<Int>? = nil
for i in 0..<n {
    let node = Node(i)
    node.next = llHead
    llHead = node
}
let llTime = CFAbsoluteTimeGetCurrent() - t2

print(String(format: "Array insert(at:0) ×%d:  %.4f초", n, arrTime))
print(String(format: "LinkedList prepend ×%d:  %.4f초", n, llTime))
/*:
 > LinkedList의 prepend가 Array의 insert(at: 0)보다 훨씬 빠른 것을 확인하세요.
 > 배열은 매번 모든 원소를 한 칸씩 뒤로 밀어야 하기 때문입니다.

 [다음 → 실습](@next)
*/
