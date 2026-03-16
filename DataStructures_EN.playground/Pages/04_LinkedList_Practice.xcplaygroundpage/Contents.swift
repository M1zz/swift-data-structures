//: [← Back to Concepts](@previous)
/*:
 # Ch.02 Practice — Linked List

 Node와 LinkedList를 implement it yourself.
*/
import Foundation

// ── Helper ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── Node 클래스 ──
final class Node<T> {
    var value: T
    var next: Node<T>?
    init(_ value: T) { self.value = value }
}

// ── Exercise 1: LinkedList 구현 ──
struct LinkedList<T>: CustomStringConvertible {
    private(set) var head: Node<T>?
    private(set) var tail: Node<T>?
    private(set) var count: Int = 0

    // TODO: prepend — 맨 앞에 추가 (O(1))
    mutating func prepend(_ value: T) {
        let node = Node(value)
        node.next = head
        head = node
        if tail == nil { tail = head }
        count += 1
    }

    // TODO: append — 맨 뒤에 추가 (O(1))
    mutating func append(_ value: T) {
        let node = Node(value)
        if tail == nil {
            head = node
            tail = node
        } else {
            tail?.next = node
            tail = node
        }
        count += 1
    }

    // TODO: removeFirst — 맨 앞 제거 (O(1))
    @discardableResult
    mutating func removeFirst() -> T? {
        guard let current = head else { return nil }
        head = current.next
        if head == nil { tail = nil }
        count -= 1
        return current.value
    }

    var description: String {
        var result = "["
        var current = head
        while let node = current {
            result += "\(node.value)"
            if node.next != nil { result += " → " }
            current = node.next
        }
        return result + "]  (count: \(count))"
    }
}

// ── Test ──
var list = LinkedList<Int>()
list.append(10)
list.append(20)
list.append(30)
print("append 10,20,30:", list)

list.prepend(5)
print("prepend(5):", list)

print("removeFirst():", list.removeFirst() ?? "nil")
print("제거 후:", list)

// ── Exercise 2: 성능 비교 ──
divider("Performance Comparison")
let n = 50_000

measureTime("Array prepend ×\(n)") {
    var arr: [Int] = []
    for i in 0..<n { arr.insert(i, at: 0) }
}

measureTime("LinkedList prepend ×\(n)") {
    var ll = LinkedList<Int>()
    for i in 0..<n { ll.prepend(i) }
}

/*:
 ## Challenges
 1. `reverse()` 메서드를 구현해서 리스트 순서를 뒤집어보세요
 2. `LinkedList`를 `Sequence` 프로토콜에 채택해 `for-in` 루프를 지원하게 만들어보세요
 3. 중간 노드를 찾는 `middle()` 함수를 작성해보세요 (투 포인터 기법)
*/
