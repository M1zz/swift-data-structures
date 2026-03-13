//: # Ch.02 — Linked List
//: 포인터로 연결된 노드 체인을 Swift로 직접 구현합니다.

import Foundation

//: ## 1. 노드 정의
final class Node<T> {
    var value: T
    var next: Node<T>?
    init(_ value: T) { self.value = value }
}

//: ## 2. LinkedList 완전 구현
struct LinkedList<T>: CustomStringConvertible {
    private(set) var head: Node<T>?
    private(set) var tail: Node<T>?
    private(set) var count: Int = 0

    // O(1) — head 교체
    mutating func prepend(_ value: T) {
        let node = Node(value)
        node.next = head
        head = node
        if tail == nil { tail = head }
        count += 1
    }

    // O(1) — tail 연결
    mutating func append(_ value: T) {
        let node = Node(value)
        if tail == nil { head = node; tail = node }
        else { tail?.next = node; tail = node }
        count += 1
    }

    // O(1) — head 이동
    @discardableResult
    mutating func removeFirst() -> T? {
        guard let current = head else { return nil }
        head = current.next
        if head == nil { tail = nil }
        count -= 1
        return current.value
    }

    // O(n) — 순회 필요
    func node(at index: Int) -> Node<T>? {
        guard index >= 0, index < count else { return nil }
        var current = head
        for _ in 0..<index { current = current?.next }
        return current
    }

    // O(n) — 특정 인덱스 후 삽입
    mutating func insert(_ value: T, after index: Int) {
        guard let targetNode = node(at: index) else { return }
        let newNode = Node(value)
        newNode.next = targetNode.next
        targetNode.next = newNode
        if targetNode === tail { tail = newNode }
        count += 1
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

//: ## 3. 실행 테스트
print("=== Linked List 실습 ===")
var list = LinkedList<Int>()
list.append(10)
list.append(20)
list.append(30)
print("초기:", list)

list.prepend(5)
print("prepend(5):", list)

list.insert(15, after: 1)
print("insert(15, after:1):", list)

print("removeFirst():", list.removeFirst()!)
print("제거 후:", list)

print("node(at: 2):", list.node(at: 2)?.value ?? "nil")

//: ## 4. Array vs LinkedList 성능 비교
print("\n=== insert/remove 성능 비교 ===")
let n = 50_000

// Array prepend — O(n) × n = O(n²)
var arr: [Int] = []
let t1 = Date()
for i in 0..<n { arr.insert(i, at: 0) }
print(String(format: "Array prepend ×%d:    %.1fms", n, Date().timeIntervalSince(t1)*1000))

// LinkedList prepend — O(1) × n = O(n)
var ll = LinkedList<Int>()
let t2 = Date()
for i in 0..<n { ll.prepend(i) }
print(String(format: "LinkedList prepend ×%d: %.1fms", n, Date().timeIntervalSince(t2)*1000))

//: ## 실습 과제
//: 1. 역방향 연결리스트(reverse)를 구현해보세요.
//: 2. 중간 노드를 O(n)으로 찾는 함수를 작성하세요.
//: 3. LinkedList를 Sequence 프로토콜에 채택해 for-in 루프를 지원하게 만들어보세요.
