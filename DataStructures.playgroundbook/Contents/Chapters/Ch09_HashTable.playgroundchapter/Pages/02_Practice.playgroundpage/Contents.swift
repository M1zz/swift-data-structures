//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.09 실습 — Hash Table

 Hash Table을 직접 구현하고, rehashing까지 구현해보세요.
*/
import Foundation

// ── 헬퍼 ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── 실습 1: HashTable 구현 ──
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

    // TODO: subscript 구현 (get/set)
    subscript(key: Key) -> Value? {
        get { getValue(for: key) }
        set {
            if let v = newValue { setValue(v, for: key) }
            else { removeValue(for: key) }
        }
    }

    // TODO: insert/update
    mutating func setValue(_ value: Value, for key: Key) {
        let i = index(for: key)
        if let idx = buckets[i].firstIndex(where: { $0.key == key }) {
            buckets[i][idx].value = value
        } else {
            buckets[i].append((key, value))
            count += 1
            if loadFactor > 0.75 { rehash() }
        }
    }

    // TODO: search
    func getValue(for key: Key) -> Value? {
        let i = index(for: key)
        return buckets[i].first(where: { $0.key == key })?.value
    }

    // TODO: delete
    mutating func removeValue(for key: Key) {
        let i = index(for: key)
        if let idx = buckets[i].firstIndex(where: { $0.key == key }) {
            buckets[i].remove(at: idx)
            count -= 1
        }
    }

    // TODO: rehash — 용량 2배 확장 + 재배치
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

// ── 테스트 ──
divider("HashTable 테스트")
var ht = HashTable<String, Int>()
let words = ["swift", "apple", "ios", "xcode", "combine", "swiftui", "uikit", "arkit"]
for word in words {
    ht[word] = word.count
}
print(ht)
print("\ncount:", ht.count)
print("loadFactor:", String(format: "%.2f", ht.loadFactor))

divider("조회/삭제")
print("ht['swift']:", ht["swift"] ?? "nil")
ht["uikit"] = nil
print("remove 'uikit' → count:", ht.count)

// ── 실습 2: Dictionary vs HashTable 성능 비교 ──
divider("성능 비교")
let n = 100_000

measureTime("Swift Dictionary insert ×\(n)") {
    var dict: [Int: Int] = [:]
    for i in 0..<n { dict[i] = i }
}

measureTime("HashTable insert ×\(n)") {
    var ht = HashTable<Int, Int>()
    for i in 0..<n { ht.setValue(i, for: i) }
}

/*:
 ## 도전 과제
 1. **Open Addressing**: Separate Chaining 대신 Linear Probing으로 충돌을 해결해보세요
 2. 의도적으로 해시 충돌을 만드는 `CustomHashable` 타입을 구현해보세요
 3. `contains()` vs `Set.contains()` 성능을 100만 원소로 비교해보세요
*/
