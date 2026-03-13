//: # Ch.04 — Deque (Double-ended Queue)
//: 링 버퍼 기반 양방향 큐. 앞/뒤 모두 O(1).
import Foundation

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

    private mutating func resize() {
        let newCap = capacity * 2
        var newBuf: [T?] = Array(repeating: nil, count: newCap)
        for i in 0..<count { newBuf[i] = buf[(head + i) % capacity] }
        buf = newBuf; head = 0; capacity = newCap
        print("  → resize! capacity: \(capacity/2) → \(capacity)")
    }

    mutating func pushFront(_ v: T) {
        if count == capacity { resize() }
        head = (head - 1 + capacity) % capacity
        buf[head] = v; count += 1
    }
    mutating func pushBack(_ v: T) {
        if count == capacity { resize() }
        buf[(head + count) % capacity] = v; count += 1
    }
    @discardableResult mutating func popFront() -> T? {
        guard !isEmpty else { return nil }
        let v = buf[head]; buf[head] = nil
        head = (head + 1) % capacity; count -= 1; return v
    }
    @discardableResult mutating func popBack() -> T? {
        guard !isEmpty else { return nil }
        let i = (head + count - 1) % capacity
        let v = buf[i]; buf[i] = nil; count -= 1; return v
    }

    var description: String {
        let els = (0..<count).map { buf[(head + $0) % capacity].map { "\($0)" } ?? "nil" }
        return "Deque[\(els.joined(separator: ", "))] head:\(head) cap:\(capacity)"
    }
}

print("=== Deque 실습 ===")
var dq = Deque<Int>(capacity: 4)
dq.pushBack(1); dq.pushBack(2); dq.pushBack(3)
print("pushBack 1,2,3:", dq)
dq.pushFront(0)
print("pushFront(0):", dq)
dq.pushBack(4) // resize 발생!
print("pushBack(4) → resize:", dq)
print("popFront:", dq.popFront()!, dq)
print("popBack:", dq.popBack()!, dq)

// 슬라이딩 윈도우 최댓값 (Deque 대표 알고리즘)
print("\n=== 슬라이딩 윈도우 최댓값 (k=3) ===")
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    var dq = Deque<Int>()  // 인덱스 저장
    var result: [Int] = []
    for i in 0..<nums.count {
        while !dq.isEmpty, let b = dq.back, nums[b] <= nums[i] { dq.popBack() }
        dq.pushBack(i)
        if let f = dq.front, f <= i - k { dq.popFront() }
        if i >= k - 1 { result.append(nums[dq.front!]) }
    }
    return result
}
print(maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3))  // [3,3,5,5,6,7]
//: 실습: 슬라이딩 윈도우 최솟값도 구현해보세요.
