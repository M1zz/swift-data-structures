//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.07 실습 — Heap / Priority Queue

 Heap을 직접 구현하고, 우선순위 큐를 만들어보세요.
*/
import Foundation

// ── 헬퍼 ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── 실습 1: Heap 구현 ──
struct Heap<T> {
    private var elements: [T]
    private let comparator: (T, T) -> Bool

    init(_ comparator: @escaping (T, T) -> Bool) {
        elements = []; self.comparator = comparator
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var top: T? { elements.first }

    // TODO: insert — 삽입 후 siftUp
    mutating func insert(_ v: T) {
        elements.append(v)
        siftUp(from: elements.count - 1)
    }

    // TODO: remove — 루트 제거 후 siftDown
    @discardableResult mutating func remove() -> T? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let removed = elements.removeLast()
        if !isEmpty { siftDown(from: 0) }
        return removed
    }

    // TODO: siftUp — 자식이 부모보다 우선이면 교환
    private mutating func siftUp(from index: Int) {
        var child = index
        while child > 0 {
            let parent = (child - 1) / 2
            guard comparator(elements[child], elements[parent]) else { break }
            elements.swapAt(child, parent)
            child = parent
        }
    }

    // TODO: siftDown — 부모가 자식보다 후순위면 교환
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

// ── 테스트 ──
divider("Min-Heap")
var minHeap = Heap<Int>(<)
[5, 3, 8, 1, 9, 2, 7].forEach { minHeap.insert($0) }
print("top:", minHeap.top!)

var sorted: [Int] = []
while !minHeap.isEmpty { sorted.append(minHeap.remove()!) }
print("Heap Sort:", sorted)

divider("Max-Heap")
var maxHeap = Heap<Int>(>)
[5, 3, 8, 1, 9, 2, 7].forEach { maxHeap.insert($0) }
print("top:", maxHeap.top!)

// ── 실습 2: 작업 우선순위 큐 ──
divider("작업 스케줄러")

struct Task: CustomStringConvertible {
    let name: String
    let priority: Int
    var description: String { "\(name)(p:\(priority))" }
}

// TODO: 우선순위가 높은 순서대로 작업을 처리하는 큐 구현
var taskQueue = Heap<Task> { $0.priority > $1.priority }
taskQueue.insert(Task(name: "로그 전송", priority: 1))
taskQueue.insert(Task(name: "UI 렌더링", priority: 5))
taskQueue.insert(Task(name: "데이터 저장", priority: 3))
taskQueue.insert(Task(name: "알림 표시", priority: 4))
taskQueue.insert(Task(name: "캐시 정리", priority: 2))

print("실행 순서:")
while !taskQueue.isEmpty {
    print("  →", taskQueue.remove()!)
}

/*:
 ## 도전 과제
 1. `heapify` — 기존 배열을 O(n)에 힙으로 변환하는 초기화 메서드를 추가해보세요
 2. iOS RunLoop의 **타이머 스케줄링**을 Min-Heap으로 모델링해보세요
 3. **Top-K 문제**: 배열에서 가장 큰 K개 원소를 Min-Heap으로 효율적으로 구해보세요
*/
