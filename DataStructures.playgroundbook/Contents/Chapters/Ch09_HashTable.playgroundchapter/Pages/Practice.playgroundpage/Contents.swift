//: # Ch.09 — Hash Table
//: Swift Dictionary 내부 동작을 직접 구현합니다.
import Foundation

struct HashTable<Key: Hashable, Value>: CustomStringConvertible {
    private typealias Bucket = [(key: Key, value: Value)]
    private var buckets: [Bucket]
    private(set) var count = 0
    private var capacity: Int

    init(capacity: Int = 8) {
        self.capacity = capacity
        buckets = Array(repeating: [], count: capacity)
    }

    private func index(for key: Key) -> Int { abs(key.hashValue % capacity) }

    subscript(key: Key) -> Value? {
        get { buckets[index(for: key)].first(where: { $0.key == key })?.value }
        set {
            if let v = newValue { setValue(v, for: key) }
            else { removeValue(for: key) }
        }
    }

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
        print("  → rehash! capacity: \(capacity/2) → \(capacity)")
    }

    var loadFactor: Double { Double(count) / Double(capacity) }

    var description: String {
        buckets.enumerated().compactMap { i, bucket in
            bucket.isEmpty ? nil : "[\(i)]: \(bucket.map { "\($0.key):\($0.value)" }.joined(separator: " → "))"
        }.joined(separator: "\n")
    }
}

print("=== Hash Table 실습 ===")
var ht = HashTable<String, Int>()
let words = ["swift", "apple", "ios", "xcode", "combine", "swiftui", "uikit", "arkit"]
words.forEach { ht[$0] = $0.count }
print(ht)
print("\nloadFactor:", String(format: "%.2f", ht.loadFactor))
print("ht['swift']:", ht["swift"] ?? "nil")

ht.removeValue(for: "uikit")
print("remove 'uikit'. count:", ht.count)

// Swift Dictionary hashValue 비교
print("\n=== Swift Dictionary 내부 특성 ===")
// SipHash 시드는 실행마다 달라짐
let d: [String: Int] = ["a": 1, "b": 2, "c": 3]
print("순서 보장 안됨:", d.keys.sorted())   // 정렬해야 일관성 있음
print("해시 시드 랜덤화:", "swift".hashValue != "swift".hashValue ? "매번 다름" : "같음(이 실행에서는)")
//: 실습: 해시 충돌을 의도적으로 만드는 CustomHashable 타입을 구현해보세요.
