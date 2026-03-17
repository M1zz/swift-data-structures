//: [← LinkedList](@previous) | [다음 →](@next)
/*: # Ch.03 — Stack / Queue 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 유효한 괄호 (Valid Parentheses)
// (, ), {, }, [, ] 로 이루어진 문자열이 유효한지 판단하세요.
// 예: "()[]{}" → true,  "([)]" → false
func isValid(_ s: String) -> Bool {
    // TODO:
    return false
}
assert(isValid("()[]{}") == true)
assert(isValid("([)]") == false)
assert(isValid("{[]}") == true)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 일일 온도 (Daily Temperatures)
// 오늘보다 따뜻한 날이 며칠 후에 오는지 배열로 반환하세요.
// 예: [73,74,75,71,69,72,76,73] → [1,1,4,2,1,1,0,0]
func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    // TODO: 단조 감소 스택 활용
    return []
}
assert(dailyTemperatures([73,74,75,71,69,72,76,73]) == [1,1,4,2,1,1,0,0])
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 스택 두 개로 큐 구현 (Implement Queue using Stacks)
// push, pop, peek, empty 를 O(amortized 1)로 구현하세요.
class MyQueue {
    // TODO: 프로퍼티 추가 및 메서드 구현
    func push(_ x: Int) { /* TODO */ }
    func pop() -> Int { /* TODO */ return -1 }
    func peek() -> Int { /* TODO */ return -1 }
    func empty() -> Bool { /* TODO */ return true }
}
let q = MyQueue()
q.push(1); q.push(2)
assert(q.peek() == 1)
assert(q.pop() == 1)
assert(q.empty() == false)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 최솟값 O(1) 스택 (Min Stack)
// push, pop, top, getMin을 모두 O(1)로 구현하세요.
class MinStack {
    // TODO:
    func push(_ val: Int) { /* TODO */ }
    func pop() { /* TODO */ }
    func top() -> Int { /* TODO */ return -1 }
    func getMin() -> Int { /* TODO */ return -1 }
}
let ms = MinStack()
ms.push(-2); ms.push(0); ms.push(-3)
assert(ms.getMin() == -3)
ms.pop()
assert(ms.top() == 0)
assert(ms.getMin() == -2)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 슬라이딩 윈도우 최댓값 (Sliding Window Maximum)
// 크기 k의 슬라이딩 윈도우에서 각 위치의 최댓값을 반환하세요.
// 예: [1,3,-1,-3,5,3,6,7], k=3 → [3,3,5,5,6,7]
// 시간 O(n) 목표 (단조 덱 활용)
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    // TODO:
    return []
}
assert(maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3) == [3,3,5,5,6,7])
assert(maxSlidingWindow([1], 1) == [1])
print("P5 통과 ✓")
