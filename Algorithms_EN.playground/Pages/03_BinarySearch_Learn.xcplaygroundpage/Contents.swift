//: [← 정렬 실습](@previous)
/*:
 # A2 — Binary Search

 ## 핵심 아이디어

 **정렬된** 배열에서 중간값과 비교해 탐색 범위를 절반씩 줄입니다.
 n개 원소에서 최대 log₂n번 비교로 답을 찾습니다.

 ## off-by-one — 가장 흔한 실수

 이진 탐색에서 버그의 90%는 `lo/hi/mid` 인덱스 관리 실수입니다.

 **패턴 1**: 정확한 값 탐색
 - `while lo <= hi` / `mid = lo + (hi-lo)/2`
 - 찾으면 즉시 return, 아니면 `lo = mid+1` 또는 `hi = mid-1`

 **패턴 2**: Lower Bound (target 이상의 첫 인덱스)
 - `while lo < hi` / `if arr[mid] < target { lo = mid+1 } else { hi = mid }`

 ## Parametric Search

 "조건을 만족하는 최솟값/최댓값"을 구하는 문제에 Binary Search를 적용합니다.
 - "나무를 H 이상 잘랐을 때 총 길이가 M 이상인가?" → 예/아니오 판별 함수
 - 이 판별 함수가 monotone(단조)이면 Binary Search 적용 가능

 ## In Practice?
 - `Array.firstIndex(where:)` 내부: 선형 탐색 O(n)이므로 정렬 배열엔 직접 구현 필요
 - `NSArray.index(of:inSortedRange:options:using:)`: Objective-C binary search
*/
import Foundation

// ── 패턴 1: 정확한 값 탐색 ──
func binarySearch(_ arr: [Int], _ target: Int) -> Int? {
    var lo = 0, hi = arr.count - 1
    while lo <= hi {
        let mid = lo + (hi - lo) / 2   // (lo+hi)/2 는 Int 오버플로우 가능
        if      arr[mid] == target { return mid }
        else if arr[mid] <  target { lo = mid + 1 }
        else                       { hi = mid - 1 }
    }
    return nil
}

let arr = [1, 3, 5, 7, 9, 11, 13, 15]
print("탐색 7  → 인덱스 \(binarySearch(arr, 7)  ?? -1)")  // 3
print("탐색 6  → 인덱스 \(binarySearch(arr, 6)  ?? -1)")  // -1 (없음)
print("탐색 15 → 인덱스 \(binarySearch(arr, 15) ?? -1)")  // 7

// ── 패턴 2: Lower Bound ──
func lowerBound(_ arr: [Int], _ target: Int) -> Int {
    var lo = 0, hi = arr.count
    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if arr[mid] < target { lo = mid + 1 } else { hi = mid }
    }
    return lo  // target 이상의 첫 인덱스 (없으면 arr.count)
}

func upperBound(_ arr: [Int], _ target: Int) -> Int {
    var lo = 0, hi = arr.count
    while lo < hi {
        let mid = lo + (hi - lo) / 2
        if arr[mid] <= target { lo = mid + 1 } else { hi = mid }
    }
    return lo  // target 초과의 첫 인덱스
}

let arr2 = [1, 2, 2, 2, 3, 4, 5]
let lb = lowerBound(arr2, 2)
let ub = upperBound(arr2, 2)
print("\n2의 Lower Bound: \(lb)")           // 1
print("2의 Upper Bound: \(ub)")             // 4
print("2의 개수: \(ub - lb)")               // 3

// ── Parametric Search: 나무 자르기 ──
// 톱으로 나무를 높이 H로 자를 때, 잘린 조각의 합이 M 이상이 되는 최대 H를 구하세요.
let trees = [20, 15, 10, 17]
let M = 7

func canGet(_ trees: [Int], height H: Int) -> Bool {
    trees.reduce(0) { $0 + max(0, $1 - H) } >= M
}

var lo = 0, hi = trees.max()!
while lo < hi {
    let mid = lo + (hi - lo + 1) / 2  // 최대값 구할 땐 올림 mid
    if canGet(trees, height: mid) { lo = mid } else { hi = mid - 1 }
}
print("\n최대 절단 높이: \(lo)")  // 15

/*:
 > **Observation Points**
 > - Lower Bound와 Upper Bound의 `lo < hi` / `hi = mid` 패턴을 정확히 이해하세요.
 > - Parametric Search에서 최솟값/최댓값 중 어느 것을 구하는지에 따라 mid 계산이 다릅니다.

 [Next → Practice](@next)
*/
