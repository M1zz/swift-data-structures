//: > **Tip**: Enable **Editor → Show Rendered Markup** in Xcode to render the markup.
/*:
 # Ch.03 — Stack / Queue

 ## 핵심 개념: LIFO vs FIFO

 - **Stack (LIFO)**: 마지막에 넣은 것이 먼저 나옴 — 접시 쌓기
 - **Queue (FIFO)**: 먼저 넣은 것이 먼저 나옴 — 줄 서기

 ## 이중 스택 큐 (Dual-Stack Queue)

 일반 배열로 Queue를 만들면 `dequeue`가 O(n)이 됩니다 (앞 원소 제거 → 전부 이동).
 **이중 스택** 트릭으로 **amortized O(1)**을 달성할 수 있습니다:

 - `inbox`: enqueue 전용 (append)
 - `outbox`: dequeue 전용 (popLast)
 - outbox가 비면 inbox를 reverse해서 outbox에 옮김

 ## Time Complexity

 **Time Complexity**
 - **push / enqueue**: Stack O(1) / Queue O(1)
 - **pop / dequeue**: Stack O(1) / Queue O(1)* amortized
 - **peek / front**: Stack O(1) / Queue O(1)
 - **isEmpty**: Stack O(1) / Queue O(1)

 ## In Practice?
 - **UINavigationController**: push/pop으로 화면 전환 (Stack)
 - **OperationQueue**: 작업을 FIFO로 처리 (Queue)
 - **Undo/Redo**: 실행 취소 스택, 다시 실행 스택
 - **괄호 검사, 수식 계산**: 컴파일러 내부에서 Stack 활용
*/
import Foundation

// ── Stack 구현 ──
struct Stack<T>: CustomStringConvertible {
    private var storage: [T] = []
    mutating func push(_ element: T) { storage.append(element) }
    @discardableResult mutating func pop() -> T? { storage.popLast() }
    var peek: T? { storage.last }
    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    var description: String { "Stack\(storage)" }
}

// ── 괄호 검사 데모 (Stack 대표 활용) ──
print("=== 균형 괄호 검사 ===")
func isBalanced(_ s: String) -> Bool {
    var stack = Stack<Character>()
    let pairs: [Character: Character] = [")": "(", "]": "[", "}": "{"]
    for c in s {
        if "([{".contains(c) { stack.push(c) }
        else if let match = pairs[c] {
            guard stack.pop() == match else { return false }
        }
    }
    return stack.isEmpty
}

print("'({[]})' →", isBalanced("({[]})"))   // true
print("'([)]'  →", isBalanced("([)]"))      // false
print("'{{}}'  →", isBalanced("{{}}"))      // true

// ── Queue (이중 스택) 구현 ──
struct Queue<T>: CustomStringConvertible {
    private var inbox: [T] = []
    private var outbox: [T] = []

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

// ── Queue 데모 ──
print("\n=== Queue (FIFO) ===")
var queue = Queue<String>()
["A", "B", "C"].forEach { queue.enqueue($0) }
print("enqueue A,B,C:", queue)
print("dequeue:", queue.dequeue()!)  // A
print("dequeue:", queue.dequeue()!)  // B
queue.enqueue("D")
print("enqueue D:", queue)
print("dequeue:", queue.dequeue()!)  // C
print("dequeue:", queue.dequeue()!)  // D
/*:
 > Stack은 **깊이 우선 탐색(DFS)**, Queue는 **너비 우선 탐색(BFS)**의 핵심 도구입니다.

 [Next → Practice](@next)
*/
