//: [← Back to Concepts](@previous)
/*:
 # Ch.04 Practice — Deque

 링 버퍼 기반 Deque를 직접 구현하고, 슬라이딩 윈도우 알고리즘에 활용해보세요.
*/
import Foundation

// ── Helper ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── Exercise 1: Deque 구현 ──
struct Deque<T>: CustomStringConvertible {
    private var buf: [T?]
    private var head: Int
    private var count: Int
    private var capacity: Int

    init(capacity: Int = 8) {
        self.capacity = capacity
        buf = Array(repeating: nil, count: capacity)
        head = capacity / 2
        count = 0
    }

    var isEmpty: Bool { count == 0 }
    var front: T? { isEmpty ? nil : buf[head % capacity] }
    var back: T? { isEmpty ? nil : buf[(head + count - 1) % capacity] }

    // TODO: resize — 용량 2배 확장
    private mutating func resize() {
        let newCap = capacity * 2
        var newBuf: [T?] = Array(repeating: nil, count: newCap)
        for i in 0..<count { newBuf[i] = buf[(head + i) % capacity] }
        buf = newBuf; head = 0; capacity = newCap
    }

    // TODO: pushFront — 앞에 추가
    mutating func pushFront(_ v: T) {
        if count == capacity { resize() }
        head = (head - 1 + capacity) % capacity
        buf[head] = v; count += 1
    }

    // TODO: pushBack — 뒤에 추가
    mutating func pushBack(_ v: T) {
        if count == capacity { resize() }
        buf[(head + count) % capacity] = v; count += 1
    }

    // TODO: popFront — 앞에서 제거
    @discardableResult mutating func popFront() -> T? {
        guard !isEmpty else { return nil }
        let v = buf[head]; buf[head] = nil
        head = (head + 1) % capacity; count -= 1; return v
    }

    // TODO: popBack — 뒤에서 제거
    @discardableResult mutating func popBack() -> T? {
        guard !isEmpty else { return nil }
        let i = (head + count - 1) % capacity
        let v = buf[i]; buf[i] = nil; count -= 1; return v
    }

    var description: String {
        let els = (0..<count).map { buf[(head + $0) % capacity].map { "\($0)" } ?? "nil" }
        return "Deque[\(els.joined(separator: ", "))]"
    }
}

// ── Test ──
divider("Deque 테스트")
var dq = Deque<Int>(capacity: 4)
dq.pushBack(1); dq.pushBack(2); dq.pushBack(3)
dq.pushFront(0)
print("pushBack 1,2,3 + pushFront 0:", dq)
print("front:", dq.front!)
print("back:", dq.back!)
print("popFront:", dq.popFront()!)
print("popBack:", dq.popBack()!)
print("남은:", dq)

// ── Exercise 2: 슬라이딩 윈도우 최댓값 ──
divider("슬라이딩 윈도우 최댓값 (k=3)")

// TODO: Deque를 사용해 슬라이딩 윈도우 최댓값 구하기
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var dq = Deque<Int>()  // 인덱스 저장
    var result: [Int] = []
    for i in 0..<nums.count {
        // 뒤에서부터 현재보다 작은 값 제거
        while !dq.isEmpty, let b = dq.back, nums[b] <= nums[i] { dq.popBack() }
        dq.pushBack(i)
        // 윈도우 범위 밖 제거
        if let f = dq.front, f <= i - k { dq.popFront() }
        // 윈도우 완성 시 최댓값 기록
        if i >= k - 1 { result.append(nums[dq.front!]) }
    }
    return result
}

let nums = [1, 3, -1, -3, 5, 3, 6, 7]
print("입력: \(nums), k=3")
print("결과: \(maxSlidingWindow(nums, 3))")  // [3, 3, 5, 5, 6, 7]

/*:
 ## Challenges
 1. 슬라이딩 윈도우 **최솟값**도 구현해보세요
 2. 최근 N개 메시지만 유지하는 채팅 버퍼를 Deque로 구현해보세요
 3. Deque를 `Collection` 프로토콜에 채택해보세요
*/
