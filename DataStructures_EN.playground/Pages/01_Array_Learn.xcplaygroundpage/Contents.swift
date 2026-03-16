//: > **Tip**: Enable **Editor → Show Rendered Markup** in Xcode to render the markup.
/*:
 # Ch.01 — Array vs ContiguousArray

 ## Core Concept: Copy-on-Write (CoW)

 Swift's `Array` is a **value type** but internally references a heap buffer.
 Copying doesn't immediately double memory — they **share the same buffer**.

 Only when a mutation occurs does the buffer actually get copied.
 This is **CoW (Copy-on-Write)**.

 ## Array vs ContiguousArray

 **Array vs ContiguousArray Comparison**
 - **Obj-C Bridging**: Array ⭕ / ContiguousArray ❌
 - **Contiguous Memory**: Array △ / ContiguousArray ⭕
 - **Performance**: Array general / ContiguousArray better for numeric computation

 > `ContiguousArray` has no Obj-C bridging, so contiguous memory is always guaranteed.
 > Up to 2x faster than Array for bulk numeric ops like audio buffers, image pixels, ML tensors.

 ## Time Complexity

 **Time Complexity**
 - **subscript [i]**: O(1) — direct contiguous memory access
 - **append()**: O(1)* — amortized, 2x reallocation
 - **insert(at:)**: O(n) — shifts all subsequent elements
 - **remove(at:)**: O(n) — shifts all subsequent elements
 - **contains()**: O(n) — linear search

 ## In Practice?
 - **UITableView/CollectionView** 데이터 소스: `[Product]` 배열
 - **JSON 디코딩**: `let items: [Product] = try decoder.decode(...)`
 - **ContiguousArray**: 오디오 샘플 버퍼, vDSP 수치 연산
*/
import Foundation

// ── CoW Verification ──
var a = [1, 2, 3]
var b = a  // Still sharing the same buffer!

print("Before modifying a:")
print("  a: \(a)")
print("  b: \(b)")

b.append(99)  // CoW triggers at this moment!
print("\nb 수정 후 (CoW 발동):")
print("  a: \(a)")  // [1, 2, 3] 그대로
print("  b: \(b)")  // [1, 2, 3, 99]

// ── Capacity Tracking ──
var arr: [Int] = []
print("\n용량 변화 추적:")
for i in 1...10 {
    arr.append(i)
    print("  count: \(arr.count), capacity: \(arr.capacity)")
}
/*:
 > Notice how capacity grows **2x**: 2, 4, 8, 16…
 > This is why append() is amortized O(1).

 [Next → Practice](@next)
*/
