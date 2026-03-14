//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.01 실습 — Array vs ContiguousArray

 아래 TODO를 채워서 직접 구현해보세요.
*/
import Foundation

// ── 헬퍼 ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

// ── 실습 1: CoW 동작 확인 ──
// TODO: 배열 a를 만들고, b에 복사한 뒤, b를 수정해서 CoW를 발동시키세요
var a = [10, 20, 30]
// 여기에 코드를 작성하세요



// ── 실습 2: Array vs ContiguousArray 성능 비교 ──
let n = 100_000

// TODO: Array<Int>에 0..<n을 append하는 시간 측정
measureTime("Array append") {
    var arr = [Int]()
    for i in 0..<n { arr.append(i) }
}

// TODO: ContiguousArray<Int>에 0..<n을 append하는 시간 측정
measureTime("ContiguousArray append") {
    var arr = ContiguousArray<Int>()
    for i in 0..<n { arr.append(i) }
}

// ── 실습 3: ArraySlice 메모리 공유 확인 ──
// TODO: 배열의 slice를 만들고, 원본과 메모리를 공유하는지 확인하세요
let original = Array(0..<10)
let slice = original[2..<5]
print("slice: \(Array(slice))")
print("slice.startIndex: \(slice.startIndex)")  // 2부터 시작!

/*:
 ## 도전 과제
 1. `reserveCapacity()`를 사용하면 성능이 얼마나 좋아지는지 측정해보세요
 2. `contains()` vs `Set.contains()` 성능을 비교해보세요 (Ch.09 Hash Table 미리보기!)
*/
