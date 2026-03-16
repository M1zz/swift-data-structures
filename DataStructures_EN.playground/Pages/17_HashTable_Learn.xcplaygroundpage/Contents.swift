//: > **Tip**: Enable **Editor → Show Rendered Markup** in Xcode to render the markup.
/*:
 # Ch.09 — Hash Table

 ## 핵심 개념: 해시 함수와 collision resolution

 Hash Table은 **키(Key)**를 **해시 함수**로 변환해 **배열 인덱스**에 매핑하는 자료구조입니다.
 이상적으로 O(1) 탐색/삽입/삭제가 가능합니다.

 ```
 key "swift" → hashValue → % capacity → index 3
 key "apple" → hashValue → % capacity → index 3  ← 충돌!
 ```

 ## Collision Resolution: Separate Chaining

 같은 인덱스에 여러 키가 매핑되면, **연결 리스트(또는 배열)**로 이어 붙입니다:

 ```
 [0]: []
 [1]: []
 [2]: [("ios", 3)]
 [3]: [("swift", 5) → ("apple", 5)]  ← 체이닝
 [4]: []
 ```

 ## Load Factor와 Rehash

 - **Load Factor** = count / capacity
 - Load Factor가 0.75를 넘으면 **rehash** (용량 2배 + 재배치)
 - Rehash 후 충돌이 줄어들어 성능 유지

 ## Time Complexity

 **Time Complexity**
 - **insert**: 평균 O(1) / 최악 O(n) — 충돌 시 체인 탐색
 - **search**: 평균 O(1) / 최악 O(n) — 충돌 시 체인 탐색
 - **delete**: 평균 O(1) / 최악 O(n) — 충돌 시 체인 탐색
 - **rehash**: O(n) — 전체 재배치

 ## In Practice?
 - **Swift Dictionary**: 내부적으로 해시 테이블 (SipHash 사용)
 - **Set**: 중복 제거 (Hash Table 기반)
 - **이미지 캐시**: URL → UIImage 매핑
 - **API 응답 캐싱**: request key → response data
*/
import Foundation

// ── Hash Table 구현 ──
struct HashTable<Key: Hashable, Value>: CustomStringConvertible {
    private typealias Bucket = [(key: Key, value: Value)]
    private var buckets: [Bucket]
    private(set) var count = 0
    private var capacity: Int

    init(capacity: Int = 8) {
        self.capacity = capacity
        buckets = Array(repeating: [], count: capacity)
    }

    private func index(for key: Key) -> Int {
        abs(key.hashValue % capacity)
    }

    // 삽입
    mutating func setValue(_ value: Value, for key: Key) {
        let i = index(for: key)
        if let idx = buckets[i].firstIndex(where: { $0.key == key }) {
            buckets[i][idx].value = value  // 업데이트
        } else {
            buckets[i].append((key, value))  // 새 항목
            count += 1
            if loadFactor > 0.75 { rehash() }
        }
    }

    // 조회
    func getValue(for key: Key) -> Value? {
        let i = index(for: key)
        return buckets[i].first(where: { $0.key == key })?.value
    }

    // 삭제
    mutating func removeValue(for key: Key) {
        let i = index(for: key)
        if let idx = buckets[i].firstIndex(where: { $0.key == key }) {
            buckets[i].remove(at: idx)
            count -= 1
        }
    }

    private mutating func rehash() {
        let old = buckets
        capacity *= 2
        buckets = Array(repeating: [], count: capacity)
        count = 0
        old.flatMap { $0 }.forEach { setValue($0.value, for: $0.key) }
        print("  → rehash! 새 capacity: \(capacity)")
    }

    var loadFactor: Double { Double(count) / Double(capacity) }

    var description: String {
        buckets.enumerated().compactMap { i, bucket in
            bucket.isEmpty ? nil : "[\(i)]: \(bucket.map { "\($0.key):\($0.value)" }.joined(separator: " → "))"
        }.joined(separator: "\n")
    }
}

// ── 데모 ──
print("=== Hash Table ===")
var ht = HashTable<String, Int>(capacity: 4)
let words = ["swift", "apple", "ios", "xcode", "combine", "swiftui"]
for word in words {
    ht.setValue(word.count, for: word)
}
print(ht)
print("\ncount:", ht.count)
print("loadFactor:", String(format: "%.2f", ht.loadFactor))
print("getValue('swift'):", ht.getValue(for: "swift") ?? "nil")

// ── 해시 충돌 시각화 ──
print("\n=== 해시 충돌 확인 ===")
let testWords = ["abc", "bca", "cab", "xyz"]
for word in testWords {
    let hash = abs(word.hashValue % 8)
    print("  '\(word)' → bucket \(hash)")
}
/*:
 > Swift의 `hashValue`는 **SipHash** 알고리즘을 사용하며,
 > 실행마다 **랜덤 시드**가 달라져 해시값이 매번 바뀝니다.
 > 이는 Hash DoS 공격을 방지하기 위한 보안 기능입니다.

 [Next → Practice](@next)
*/
