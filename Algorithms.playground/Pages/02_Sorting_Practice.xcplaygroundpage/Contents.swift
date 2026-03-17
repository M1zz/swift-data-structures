//: [← 개념으로 돌아가기](@previous)
/*:
 # A1 실습 — Sorting
 아래 TODO를 채워서 직접 구현해보세요.
*/
import Foundation

// ── 실습 1: Median-of-3 Quick Sort ──
// pivot을 lo, mid, hi 세 원소의 중간값으로 선택하면
// 이미 정렬된 배열에서도 O(n²)이 발생하지 않습니다.
func partition_m3(_ arr: inout [Int], _ lo: Int, _ hi: Int) -> Int {
    let mid = lo + (hi - lo) / 2

    // 세 후보 중 중간값을 hi 위치로 옮겨 pivot으로 사용
    // lo < mid < hi 순으로 정렬하여 중간값(mid)을 pivot 자리(hi)에 놓는다
    if arr[lo] > arr[mid] { arr.swapAt(lo, mid) }  // lo ≤ mid 보장
    if arr[lo] > arr[hi]  { arr.swapAt(lo, hi)  }  // lo ≤ hi  보장
    if arr[mid] > arr[hi] { arr.swapAt(mid, hi) }  // mid ≤ hi 보장
    // 이 시점에서 arr[mid]가 세 값의 중간값 → hi 자리로 이동
    arr.swapAt(mid, hi)

    let pivot = arr[hi]
    var i = lo
    for j in lo..<hi {
        if arr[j] <= pivot { arr.swapAt(i, j); i += 1 }
    }
    arr.swapAt(i, hi)
    return i
}

// ── 실습 2: 안정 정렬 확인 ──
// 같은 key를 가진 원소들의 상대 순서가 유지되는지 확인합니다.
struct Student: CustomStringConvertible {
    let name: String
    let grade: Int
    var description: String { "\(name)(\(grade))" }
}

let students = [
    Student(name: "철수", grade: 2),
    Student(name: "영희", grade: 1),
    Student(name: "민수", grade: 2),
    Student(name: "지현", grade: 1),
]

// Swift의 sorted(by:)는 안정 정렬(Stable Sort) 보장
// 같은 grade 내에서 원래 순서(영희→지현, 철수→민수)가 유지됨
let sorted = students.sorted { $0.grade < $1.grade }
print("안정 정렬 결과: \(sorted)")
// 예상: [영희(1), 지현(1), 철수(2), 민수(2)] — 같은 grade에서 원래 순서 유지

// ── 실습 3: k번째 최솟값 (Quick Select) ──
// Quick Sort의 partition을 응용하여 O(n) average로 k번째 최솟값을 구합니다.
// partition 후 pivot 위치 p와 k를 비교:
//   p == k → arr[p]가 답
//   p >  k → 왼쪽 절반만 재귀
//   p <  k → 오른쪽 절반만 재귀
func quickSelect(_ arr: inout [Int], _ lo: Int, _ hi: Int, _ k: Int) -> Int {
    guard lo < hi else { return arr[lo] }  // 원소가 하나면 그것이 답

    // median-of-3 방식으로 pivot 선택 (최악 케이스 완화)
    let mid = lo + (hi - lo) / 2
    if arr[lo] > arr[mid] { arr.swapAt(lo, mid) }
    if arr[lo] > arr[hi]  { arr.swapAt(lo, hi)  }
    if arr[mid] > arr[hi] { arr.swapAt(mid, hi) }
    arr.swapAt(mid, hi)

    // pivot을 기준으로 배열을 분할하고 pivot의 최종 위치 p를 얻는다
    let pivot = arr[hi]
    var i = lo
    for j in lo..<hi {
        if arr[j] <= pivot { arr.swapAt(i, j); i += 1 }
    }
    arr.swapAt(i, hi)
    let p = i

    if p == k { return arr[p] }           // pivot이 k번째 → 바로 반환
    else if p > k { return quickSelect(&arr, lo, p - 1, k) }   // 왼쪽 탐색
    else          { return quickSelect(&arr, p + 1, hi, k) }   // 오른쪽 탐색
}

var arr = [7, 2, 5, 1, 9, 3, 8, 4, 6]
let k3 = quickSelect(&arr, 0, arr.count - 1, 2)  // 0-indexed 2 → 3번째 최솟값
print("3번째 최솟값: \(k3)")  // 정답: 3

/*:
 ## 도전 과제
 1. **Counting Sort**: 값 범위가 0..<k일 때 O(n+k)로 정렬하세요.
 2. **Radix Sort**: 자릿수 기준으로 안정 정렬을 반복하여 O(nk)로 정렬하세요.
 3. **외부 정렬**: 배열이 메모리에 다 안 들어올 때 Merge Sort를 어떻게 변형할지 설계해보세요.

 [다음 → Binary Search 개념](@next)
*/
