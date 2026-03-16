//: > **Tip**: Enable **Editor → Show Rendered Markup** in Xcode to render the markup.
/*:
 # Ch.04 — Deque (Double-ended Queue)

 ## 핵심 개념: 링 버퍼 (Ring Buffer)

 Deque는 **양 끝에서 삽입/삭제가 O(1)**인 자료구조입니다.
 내부적으로 **링 버퍼(원형 배열)**를 사용합니다.

 링 버퍼는 배열의 끝과 시작이 논리적으로 연결된 구조입니다.
 **모듈러 연산(%)**으로 인덱스를 순환시킵니다:

 ```
 물리 배열: [ _, _, 3, 4, 5, _, _, _ ]
                  ^head       ^tail
 pushFront → head = (head - 1 + capacity) % capacity
 pushBack  → tail = (head + count) % capacity
 ```

 ## Time Complexity

 **Time Complexity**
 - **pushFront()**: O(1)* — amortized (resize 시 O(n))
 - **pushBack()**: O(1)* — amortized
 - **popFront()**: O(1) — head 이동
 - **popBack()**: O(1) — count 감소
 - **front / back**: O(1) — 직접 접근

 ## In Practice?
 - **채팅 메시지 버퍼**: 최근 N개 메시지만 유지 (오래된 건 앞에서 제거)
 - **Sliding Window 알고리즘**: 네트워크 패킷 처리, 이동 평균 계산
 - **작업 스케줄러**: 양 끝에서 작업 추가/제거
*/
import Foundation

// ── 링 버퍼 기반 Deque ──
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
        return "Deque[\(els.joined(separator: ", "))]  (cap: \(capacity))"
    }
}

// ── 데모 ──
print("=== Ring Buffer Deque ===")
var dq = Deque<Int>(capacity: 4)
dq.pushBack(1); dq.pushBack(2); dq.pushBack(3)
print("pushBack 1,2,3:", dq)

dq.pushFront(0)
print("pushFront(0):", dq)

dq.pushBack(4)  // resize 발생!
print("pushBack(4):", dq)

print("popFront:", dq.popFront()!, "→", dq)
print("popBack:", dq.popBack()!, "→", dq)

// ── 인덱스 순환 시각화 ──
print("\n=== 원형 인덱스 시각화 ===")
let cap = 8
for i in 0..<12 {
    let idx = i % cap
    print("  논리 인덱스 \(i) → 물리 인덱스 \(idx)")
}
/*:
 > 모듈러 연산으로 인덱스가 0~7 범위를 순환하는 것을 확인하세요.
 > 이것이 링 버퍼의 핵심 원리입니다.

 [Next → Practice](@next)
*/
