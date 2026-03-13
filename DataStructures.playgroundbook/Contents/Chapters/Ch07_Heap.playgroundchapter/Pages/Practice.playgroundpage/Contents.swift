//: # Ch.07 — Heap / Priority Queue
//: Min-Heap 구현. siftUp/siftDown의 작동 원리를 이해합니다.
import Foundation

struct Heap<T> {
    private var elements: [T]
    private let comparator: (T, T) -> Bool

    init(_ comparator: @escaping (T, T) -> Bool) {
        elements = []; self.comparator = comparator
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }
    var top: T? { elements.first }

    // O(log n)
    mutating func insert(_ v: T) {
        elements.append(v)
        siftUp(from: elements.count - 1)
    }

    // O(log n)
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

typealias PriorityQueue<T> = Heap<T>

print("=== Min-Heap ===")
var minHeap = Heap<Int>(<)
[5, 3, 8, 1, 9, 2, 7].forEach { minHeap.insert($0) }
print("heap array:", minHeap.array)
print("top(최솟값):", minHeap.top!)

var sorted: [Int] = []
while !minHeap.isEmpty { sorted.append(minHeap.remove()!) }
print("정렬 결과 (heap sort):", sorted)

print("\n=== Max-Heap ===")
var maxHeap = Heap<Int>(>)
[5, 3, 8, 1, 9, 2, 7].forEach { maxHeap.insert($0) }
print("top(최댓값):", maxHeap.top!)

print("\n=== Priority Queue — 작업 스케줄러 ===")
struct Task: CustomStringConvertible {
    let name: String; let priority: Int
    var description: String { "\(name)(p:\(priority))" }
}
var pq = PriorityQueue<Task> { $0.priority > $1.priority }
pq.insert(Task(name: "네트워크", priority: 1))
pq.insert(Task(name: "UI 업데이트", priority: 3))
pq.insert(Task(name: "애니메이션", priority: 5))
pq.insert(Task(name: "로그", priority: 2))

print("실행 순서:")
while !pq.isEmpty { print(" -", pq.remove()!) }
//: 실습: iOS RunLoop의 타이머 스케줄링을 Min-Heap으로 모델링해보세요.
