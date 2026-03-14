//: > **Tip**: Xcode 메뉴에서 **Editor → Show Rendered Markup** 을 켜면 마크업이 렌더링되어 더 읽기 쉽습니다.
/*:
 # Ch.01 — Array vs ContiguousArray

 ## 핵심 개념: Copy-on-Write (CoW)

 Swift의 `Array`는 **값 타입**이지만 내부적으로 힙 버퍼를 참조합니다.
 복사해도 바로 메모리를 두 배로 쓰지 않고, **같은 버퍼를 공유**합니다.

 수정이 발생하는 순간 — 그때 비로소 버퍼를 복제합니다.
 이것이 **CoW(Copy-on-Write)** 입니다.

 ## Array vs ContiguousArray

 **Array vs ContiguousArray 비교**
 - **Obj-C 브릿징**: Array ⭕ / ContiguousArray ❌
 - **연속 메모리 보장**: Array △ / ContiguousArray ⭕
 - **성능**: Array 일반적 / ContiguousArray 수치 연산에 유리

 > `ContiguousArray`는 Obj-C 브릿징이 없어 항상 연속 메모리가 보장됩니다.
 > 오디오 버퍼, 이미지 픽셀, ML 텐서 등 대량 수치 연산에서 Array 대비 최대 2배 빠릅니다.

 ## 시간복잡도

 **시간복잡도**
 - **subscript [i]**: O(1) — 연속 메모리 직접 접근
 - **append()**: O(1)* — amortized, 2배 재할당
 - **insert(at:)**: O(n) — 이후 원소 전부 이동
 - **remove(at:)**: O(n) — 이후 원소 전부 이동
 - **contains()**: O(n) — 선형 탐색

 ## 실무에서는?
 - **UITableView/CollectionView** 데이터 소스: `[Product]` 배열
 - **JSON 디코딩**: `let items: [Product] = try decoder.decode(...)`
 - **ContiguousArray**: 오디오 샘플 버퍼, vDSP 수치 연산
*/
import Foundation

// ── CoW 확인 ──
var a = [1, 2, 3]
var b = a  // 아직 같은 버퍼 공유!

print("a 수정 전:")
print("  a: \(a)")
print("  b: \(b)")

b.append(99)  // 이 순간 CoW 발동!
print("\nb 수정 후 (CoW 발동):")
print("  a: \(a)")  // [1, 2, 3] 그대로
print("  b: \(b)")  // [1, 2, 3, 99]

// ── 용량 추적 ──
var arr: [Int] = []
print("\n용량 변화 추적:")
for i in 1...10 {
    arr.append(i)
    print("  count: \(arr.count), capacity: \(arr.capacity)")
}
/*:
 > capacity가 2, 4, 8, 16… 으로 **2배씩** 늘어나는 것을 확인하세요.
 > 이것이 append()가 amortized O(1)인 이유입니다.

 [다음 → 실습](@next)
*/
