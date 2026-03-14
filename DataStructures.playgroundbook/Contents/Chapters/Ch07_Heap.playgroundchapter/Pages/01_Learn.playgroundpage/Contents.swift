/*:
 # Ch.07 — Heap / Priority Queue

 ## 핵심 개념: 완전 이진 트리를 배열로

 Heap은 **완전 이진 트리(Complete Binary Tree)**를 **배열**로 구현한 자료구조입니다.
 부모-자식 관계를 인덱스 계산으로 표현합니다:

 - 부모: `(i - 1) / 2`
 - 왼쪽 자식: `2 * i + 1`
 - 오른쪽 자식: `2 * i + 2`

 **Min-Heap**: 부모 ≤ 자식 (루트가 최솟값)
 **Max-Heap**: 부모 ≥ 자식 (루트가 최댓값)

 ## siftUp / siftDown

 - **siftUp**: 삽입 후 부모와 비교하며 위로 올림
 - **siftDown**: 제거 후 자식과 비교하며 아래로 내림

 ```
 insert(1):      remove():
   [3]             [1]
   / \    siftUp   / \    siftDown
  5   7  ───→    [3]  7  ───→
 /               /
[1]             5
 ```

 ## 시간복잡도

 | 연산 | 복잡도 | 비고 |
 |------|--------|------|
 | insert | O(log n) | siftUp |
 | remove (top) | O(log n) | siftDown |
 | peek (top) | O(1) | 배열 첫 원소 |
 | heapify (배열→힙) | O(n) | bottom-up |

 ## 실무에서는?
 - **우선순위 큐**: 네트워크 요청 우선순위, 작업 스케줄러
 - **Dijkstra 알고리즘**: 최단 경로 탐색에 Min-Heap 사용
 - **iOS Timer 스케줄링**: 가장 빨리 만료될 타이머를 Min-Heap으로 관리
 - **Top-K 문제**: "가장 인기 있는 K개 항목" → Max-Heap
*/
import Foundation

// ── Heap 구현 ──
struct Heap<T> {
    private var elements: [T]
    private let comparator: (T, T) -> Bool

    init(_ comparator: @escaping (T, T) -> Bool) {
        elements = []; self.comparator = comparator
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var top: T? { elements.first }

    mutating func insert(_ v: T) {
        elements.append(v)
        siftUp(from: elements.count - 1)
    }

    @discardableResult mutating func remove() -> T? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let removed = elements.removeLast()
        if !isEmpty { siftDown(from: 0) }
        return removed
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        while child > 0 {
            let parent = (child - 1) / 2
            guard comparator(elements[child], elements[parent]) else { break }
            elements.swapAt(child, parent)
            child = parent
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let l = 2 * parent + 1, r = 2 * parent + 2
            var candidate = parent
            if l < elements.count && comparator(elements[l], elements[candidate]) { candidate = l }
            if r < elements.count && comparator(elements[r], elements[candidate]) { candidate = r }
            if candidate == parent { break }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    var array: [T] { elements }
}

// ── Min-Heap 데모 ──
print("=== Min-Heap ===")
var minHeap = Heap<Int>(<)
[5, 3, 8, 1, 9, 2, 7].forEach { minHeap.insert($0) }
print("내부 배열:", minHeap.array)
print("top (최솟값):", minHeap.top!)

// Heap Sort
var sorted: [Int] = []
while !minHeap.isEmpty { sorted.append(minHeap.remove()!) }
print("정렬 결과:", sorted)

// ── 작업 스케줄러 (Priority Queue) ──
print("\n=== 작업 우선순위 큐 ===")
struct Task: CustomStringConvertible {
    let name: String; let priority: Int
    var description: String { "\(name)(p:\(priority))" }
}

var pq = Heap<Task> { $0.priority > $1.priority }
pq.insert(Task(name: "네트워크", priority: 1))
pq.insert(Task(name: "UI 업데이트", priority: 3))
pq.insert(Task(name: "애니메이션", priority: 5))
pq.insert(Task(name: "로그", priority: 2))

print("우선순위 높은 순서:")
while !pq.isEmpty { print("  -", pq.remove()!) }
/*:
 > Heap은 "전체 정렬"이 아닌 "**최솟값/최댓값만 빠르게**" 알고 싶을 때 최적입니다.
 > 전체 정렬이 필요하면 `Array.sorted()`(O(n log n))가 더 적합합니다.

 [다음 → 실습](@next)
*/
