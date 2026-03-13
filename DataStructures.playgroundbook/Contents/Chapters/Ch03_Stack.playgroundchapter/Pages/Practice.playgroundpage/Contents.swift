//: # Ch.03 — Stack / Queue
//: 프로토콜로 ADT를 정의하고, 두 가지 구현을 비교합니다.

import Foundation

//: ## 1. 프로토콜 정의 — "구현보다 인터페이스 먼저"
protocol StackProtocol {
    associatedtype Element
    mutating func push(_ element: Element)
    @discardableResult mutating func pop() -> Element?
    var peek: Element? { get }
    var isEmpty: Bool { get }
    var count: Int { get }
}

protocol QueueProtocol {
    associatedtype Element
    mutating func enqueue(_ element: Element)
    @discardableResult mutating func dequeue() -> Element?
    var front: Element? { get }
    var isEmpty: Bool { get }
}

//: ## 2. Stack — Array 기반
struct Stack<T>: StackProtocol, CustomStringConvertible {
    private var storage: [T] = []
    mutating func push(_ element: T) { storage.append(element) }
    @discardableResult mutating func pop() -> T? { storage.popLast() }
    var peek: T? { storage.last }
    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    var description: String { "Stack\(storage)" }
}

//: ## 3. Queue — 이중 Stack으로 amortized O(1) 구현
struct Queue<T>: QueueProtocol, CustomStringConvertible {
    private var inbox: [T] = []   // enqueue 전용
    private var outbox: [T] = []  // dequeue 전용

    mutating func enqueue(_ element: T) {
        inbox.append(element)   // 항상 O(1)
    }

    @discardableResult
    mutating func dequeue() -> T? {
        if outbox.isEmpty {
            // inbox → reverse → outbox (이 비용은 드물게 발생)
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.popLast()  // O(1)
    }

    var front: T? { outbox.last ?? inbox.first }
    var isEmpty: Bool { inbox.isEmpty && outbox.isEmpty }
    var description: String { "Queue inbox:\(inbox) outbox:\(outbox.reversed())" }
}

//: ## 4. Stack 실행 테스트
print("=== Stack (LIFO) ===")
var stack = Stack<Int>()
[1, 2, 3, 4, 5].forEach { stack.push($0) }
print("push 1~5:", stack)
print("peek:", stack.peek!)
print("pop:", stack.pop()!)
print("pop:", stack.pop()!)
print("남은:", stack)

//: ## 5. Queue 실행 테스트
print("\n=== Queue (FIFO) ===")
var queue = Queue<String>()
["A", "B", "C"].forEach { queue.enqueue($0) }
print("enqueue A,B,C:", queue)
print("dequeue:", queue.dequeue()!)  // A
queue.enqueue("D")
print("enqueue D, dequeue:", queue.dequeue()!)  // B
print("남은:", queue)

//: ## 6. 실전 — 균형 괄호 검사 (Stack 활용)
print("\n=== 균형 괄호 검사 ===")
func isBalanced(_ s: String) -> Bool {
    var stack = Stack<Character>()
    let open: Set<Character> = ["(", "[", "{"]
    let pairs: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    for c in s {
        if open.contains(c) { stack.push(c) }
        else if let match = pairs[c] {
            guard stack.pop() == match else { return false }
        }
    }
    return stack.isEmpty
}
print("'({[]})' →", isBalanced("({[]})"))   // true
print("'([)]'   →", isBalanced("([)]"))     // false
print("'{{}}'   →", isBalanced("{{}}"))     // true

//: ## 7. 실전 — BFS 레벨 순서 출력 (Queue 활용)
print("\n=== BFS — 레벨 순서 ===")
// 간단한 트리: 1(2,3), 2(4,5), 3(6)
let adj: [Int: [Int]] = [1:[2,3], 2:[4,5], 3:[6], 4:[], 5:[], 6:[]]
func bfs(start: Int) -> [Int] {
    var queue = Queue<Int>()
    var result: [Int] = []
    var visited: Set<Int> = []
    queue.enqueue(start)
    visited.insert(start)
    while let node = queue.dequeue() {
        result.append(node)
        (adj[node] ?? []).forEach {
            if !visited.contains($0) { queue.enqueue($0); visited.insert($0) }
        }
    }
    return result
}
print("BFS from 1:", bfs(start: 1))

//: ## 실습 과제
//: 1. Stack으로 DFS를 구현해보세요.
//: 2. UINavigationController의 push/pop을 Stack으로 모델링해보세요.
//: 3. Queue를 사용해 print 작업 스풀러를 시뮬레이션해보세요.
