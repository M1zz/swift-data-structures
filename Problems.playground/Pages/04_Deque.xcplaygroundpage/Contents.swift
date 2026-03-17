//: [← Stack/Queue](@previous) | [다음 →](@next)
/*: # Ch.04 — Deque 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 팰린드롬 확인 (Is Palindrome)
// 문자열이 팰린드롬인지 Deque를 사용하여 확인하세요.
// 영문자와 숫자만 비교, 대소문자 무시
// 예: "A man, a plan, a canal: Panama" → true
func isPalindrome(_ s: String) -> Bool {
    // TODO: Deque(양방향 비교) 활용
    return false
}
assert(isPalindrome("A man, a plan, a canal: Panama") == true)
assert(isPalindrome("race a car") == false)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P2. 슬라이딩 윈도우 평균 (Moving Average)
// 크기 k의 슬라이딩 윈도우의 이동 평균을 반환하세요.
// 예: stream=[1,10,3,5], k=3 → [1.0, 5.5, 4.666..., 6.0]
class MovingAverage {
    // TODO:
    let size: Int
    init(_ size: Int) { self.size = size }
    func next(_ val: Int) -> Double {
        // TODO:
        return 0.0
    }
}
let ma = MovingAverage(3)
assert(ma.next(1) == 1.0)
assert(ma.next(10) == 5.5)
let _ = ma.next(3)
assert(abs(ma.next(5) - 6.0) < 1e-9)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 원형 덱 구현 (Design Circular Deque)
// 배열 기반의 원형 덱을 구현하세요. (insertFront, insertLast, deleteFront, deleteLast, getFront, getRear, isEmpty, isFull)
class MyCircularDeque {
    // TODO:
    init(_ k: Int) {}
    func insertFront(_ value: Int) -> Bool { return false }
    func insertLast(_ value: Int) -> Bool { return false }
    func deleteFront() -> Bool { return false }
    func deleteLast() -> Bool { return false }
    func getFront() -> Int { return -1 }
    func getRear() -> Int { return -1 }
    func isEmpty() -> Bool { return true }
    func isFull() -> Bool { return false }
}
let cd = MyCircularDeque(3)
assert(cd.insertLast(1) == true)
assert(cd.insertLast(2) == true)
assert(cd.insertFront(3) == true)
assert(cd.insertFront(4) == false)  // 꽉 참
assert(cd.getRear() == 2)
assert(cd.isFull() == true)
assert(cd.deleteLast() == true)
assert(cd.insertFront(4) == true)
assert(cd.getFront() == 4)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P4. 가장 긴 유효 괄호 부분 문자열 (Longest Valid Parentheses)
// 올바른 괄호로 이루어진 가장 긴 부분문자열의 길이를 구하세요.
// 예: "(()" → 2,  ")()())" → 4
func longestValidParentheses(_ s: String) -> Int {
    // TODO: 스택 활용
    return 0
}
assert(longestValidParentheses("(()") == 2)
assert(longestValidParentheses(")()())") == 4)
assert(longestValidParentheses("") == 0)
print("P4 통과 ✓")
