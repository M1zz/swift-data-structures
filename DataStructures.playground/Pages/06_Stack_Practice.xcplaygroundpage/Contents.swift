//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.03 실습 — Stack / Queue

 Stack과 Queue를 직접 구현하고 활용해보세요.
*/
import Foundation

// ── 헬퍼 ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── 실습 1: Stack 구현 ──
struct Stack<T>: CustomStringConvertible {
    private var storage: [T] = []

    // TODO: push, pop, peek, isEmpty, count 구현
    mutating func push(_ element: T) { storage.append(element) }
    @discardableResult mutating func pop() -> T? { storage.popLast() }
    var peek: T? { storage.last }
    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    var description: String { "Stack\(storage)" }
}

// ── 실습 2: Queue 구현 (이중 스택) ──
struct Queue<T>: CustomStringConvertible {
    private var inbox: [T] = []
    private var outbox: [T] = []

    // TODO: enqueue, dequeue, front, isEmpty 구현
    mutating func enqueue(_ element: T) { inbox.append(element) }

    @discardableResult
    mutating func dequeue() -> T? {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.popLast()
    }

    var front: T? { outbox.last ?? inbox.first }
    var isEmpty: Bool { inbox.isEmpty && outbox.isEmpty }
    var description: String { "Queue(front← \(outbox.reversed() + inbox) →back)" }
}

// ── 테스트 ──
divider("Stack 테스트")
var stack = Stack<Int>()
[1, 2, 3, 4, 5].forEach { stack.push($0) }
print("push 1~5:", stack)
print("pop:", stack.pop()!)
print("peek:", stack.peek!)
print("남은:", stack)

divider("Queue 테스트")
var queue = Queue<String>()
["A", "B", "C"].forEach { queue.enqueue($0) }
print("enqueue A,B,C:", queue)
print("dequeue:", queue.dequeue()!)
print("front:", queue.front!)

// ── 실습 3: 브라우저 뒤로/앞으로 시뮬레이션 ──
divider("브라우저 뒤로/앞으로")

// TODO: backStack과 forwardStack을 사용해 브라우저 네비게이션 구현
var backStack = Stack<String>()
var forwardStack = Stack<String>()
var currentPage = "홈"

func visit(_ page: String) {
    backStack.push(currentPage)
    currentPage = page
    forwardStack = Stack<String>()  // 새 페이지 방문 시 forward 초기화
    print("방문: \(currentPage)")
}

func goBack() {
    guard let prev = backStack.pop() else { print("뒤로 갈 수 없음"); return }
    forwardStack.push(currentPage)
    currentPage = prev
    print("← 뒤로: \(currentPage)")
}

func goForward() {
    guard let next = forwardStack.pop() else { print("앞으로 갈 수 없음"); return }
    backStack.push(currentPage)
    currentPage = next
    print("→ 앞으로: \(currentPage)")
}

visit("검색")
visit("뉴스")
visit("메일")
goBack()        // ← 뉴스
goBack()        // ← 검색
goForward()     // → 뉴스
print("현재 페이지: \(currentPage)")

/*:
 ## 도전 과제
 1. Stack을 사용해 DFS를 구현해보세요 (재귀 없이 반복문으로)
 2. UINavigationController의 push/pop을 Stack으로 모델링해보세요
 3. Queue를 사용해 프린트 작업 스풀러를 시뮬레이션해보세요
*/
