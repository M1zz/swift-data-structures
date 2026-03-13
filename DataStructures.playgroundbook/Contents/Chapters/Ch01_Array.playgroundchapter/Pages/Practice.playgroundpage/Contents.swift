//: # Ch.01 — Array vs ContiguousArray
//: Swift 배열의 실체를 파헤쳐봅니다.

import Foundation

//: ## 1. CoW(Copy-on-Write) 직접 확인
print("=== Copy-on-Write ===")

var a = [1, 2, 3]
var b = a   // 아직 복사 없음. 같은 버퍼 공유

// isKnownUniquelyReferenced는 class에만 작동하므로 래퍼 사용
final class Wrapper<T> { var value: T; init(_ v: T) { value = v } }
var wa = Wrapper(a)
var wb = wa         // 같은 참조
print("공유 중?", !isKnownUniquelyReferenced(&wa))  // true → 공유중

b.append(99)        // 이 시점에 CoW 발동 → 버퍼 분리
print("a:", a)      // [1, 2, 3] 변화 없음
print("b:", b)      // [1, 2, 3, 99]

//: ## 2. Array vs ContiguousArray 성능 측정
print("\n=== 성능 측정 (1,000,000 원소) ===")

let n = 1_000_000
let base = (0..<n).map { $0 }

var arr: Array<Int> = base
var contArr: ContiguousArray<Int> = ContiguousArray(base)

var sum = 0
let t1 = Date()
arr.forEach { sum += $0 }
let arrTime = Date().timeIntervalSince(t1) * 1000

sum = 0
let t2 = Date()
contArr.forEach { sum += $0 }
let contTime = Date().timeIntervalSince(t2) * 1000

print(String(format: "Array:            %.2fms", arrTime))
print(String(format: "ContiguousArray:  %.2fms", contTime))
print(String(format: "차이: %.1f%%", (arrTime - contTime) / arrTime * 100))

//: ## 3. append() amortized O(1) 확인 — capacity 추적
print("\n=== Capacity 2배 성장 패턴 ===")
var growing: [Int] = []
var lastCap = 0
for i in 0..<20 {
    growing.append(i)
    if growing.capacity != lastCap {
        print("count:\(growing.count)  capacity:\(growing.capacity)")
        lastCap = growing.capacity
    }
}

//: ## 4. ArraySlice — 원본 메모리 공유
print("\n=== ArraySlice ===")
let original = Array(0..<10)
let slice: ArraySlice<Int> = original[3...6]
print("original[3...6] =", Array(slice))
print("슬라이스 startIndex:", slice.startIndex)  // 0이 아닌 3!
//: > 슬라이스는 복사 없이 원본 버퍼를 공유합니다.
//: > 장기 보관 시 Array(slice)로 독립 복사 필요

//: ## 실습 과제
//: 1. class 타입 원소를 담을 때 Array vs ContiguousArray 성능 차이를 측정해보세요.
//: 2. reserveCapacity()로 미리 공간을 확보하면 reallocation이 줄어드는지 확인하세요.
