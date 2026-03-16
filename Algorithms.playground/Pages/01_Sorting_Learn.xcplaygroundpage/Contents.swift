//: > **Tip**: Xcode 메뉴에서 **Editor → Show Rendered Markup** 을 켜면 마크업이 렌더링되어 더 읽기 쉽습니다.
/*:
 # A1 — Sorting

 ## Quick Sort vs Merge Sort vs Heap Sort

 세 알고리즘 모두 **O(n log n)** 이지만 상황에 따라 선택이 달라집니다.

 | 알고리즘 | 평균 | 최악 | 공간 | 안정 |
 |----------|------|------|------|------|
 | Quick Sort | O(n log n) | O(n²) | O(log n) | ✗ |
 | Merge Sort | O(n log n) | O(n log n) | O(n) | ✓ |
 | Heap Sort | O(n log n) | O(n log n) | O(1) | ✗ |

 > Swift의 `Array.sort()`는 **IntroSort** — Quick + Heap + Insertion Sort의 혼합입니다.
 > 작은 배열(≤20)은 Insertion Sort, 재귀 깊이 초과 시 Heap Sort로 전환합니다.

 ## Quick Sort

 **Pivot** 을 기준으로 작은 것은 왼쪽, 큰 것은 오른쪽으로 분할 정복합니다.
 캐시 친화적이라 실제 성능은 가장 빠른 경우가 많습니다.

 - **Pivot 전략**: 첫 원소 / 랜덤 / Median-of-3
 - **최악 케이스**: 이미 정렬된 배열에 첫 원소 pivot → O(n²)

 ## Merge Sort

 항상 절반씩 나누어 정렬 후 병합합니다.
 **안정 정렬(Stable Sort)** 이 필요하거나 LinkedList 정렬에 적합합니다.

 ## Heap Sort

 Heap 자료구조를 이용한 정렬. 추가 메모리가 O(1)이지만
 캐시 미스가 많아 실제론 Quick/Merge보다 느린 경우가 많습니다.

 ## 실무에서는?
 - **Swift sort()**: IntroSort (위 세 가지 혼합)
 - **안정 정렬 필요 시**: `sort(by:)` — Swift의 기본 sort는 안정 정렬 보장(SE-0372)
 - **외부 정렬 (파일)**: Merge Sort 계열
*/
import Foundation

// ── Quick Sort ──
func quickSort(_ arr: inout [Int], _ lo: Int, _ hi: Int) {
    guard lo < hi else { return }
    let p = partition(&arr, lo, hi)
    quickSort(&arr, lo, p - 1)
    quickSort(&arr, p + 1, hi)
}

func partition(_ arr: inout [Int], _ lo: Int, _ hi: Int) -> Int {
    let pivot = arr[hi]
    var i = lo
    for j in lo..<hi {
        if arr[j] <= pivot { arr.swapAt(i, j); i += 1 }
    }
    arr.swapAt(i, hi)
    return i
}

var qs = [5, 3, 8, 1, 9, 2, 7, 4, 6]
quickSort(&qs, 0, qs.count - 1)
print("Quick Sort: \(qs)")

// ── Merge Sort ──
func mergeSort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    let mid = arr.count / 2
    let left  = mergeSort(Array(arr[..<mid]))
    let right = mergeSort(Array(arr[mid...]))
    return merge(left, right)
}

func merge(_ l: [Int], _ r: [Int]) -> [Int] {
    var result: [Int] = []
    var i = 0, j = 0
    while i < l.count && j < r.count {
        if l[i] <= r[j] { result.append(l[i]); i += 1 }
        else             { result.append(r[j]); j += 1 }
    }
    return result + l[i...] + r[j...]
}

let ms = mergeSort([5, 3, 8, 1, 9, 2, 7, 4, 6])
print("Merge Sort: \(ms)")

// ── 정렬 성능 측정 ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    print("⏱ \(label): \(String(format: "%.4f", CFAbsoluteTimeGetCurrent() - start))초")
}

let n = 10_000
let randomArr = (0..<n).map { _ in Int.random(in: 0..<n) }
let sortedArr  = Array(0..<n)

print("\n── 랜덤 배열 \(n)개 ──")
measureTime("Swift sort()") { var a = randomArr; a.sort() }
measureTime("Quick Sort  ") { var a = randomArr; quickSort(&a, 0, a.count-1) }
measureTime("Merge Sort  ") { _ = mergeSort(randomArr) }

print("\n── 정렬된 배열 \(n)개 (Quick Sort 최악 케이스 주의) ──")
measureTime("Swift sort()") { var a = sortedArr; a.sort() }
measureTime("Merge Sort  ") { _ = mergeSort(sortedArr) }

/*:
 > **관찰 포인트**
 > - 랜덤 배열: Quick Sort가 빠른지 확인
 > - 정렬된 배열: Quick Sort(last pivot)가 느려지는지 확인

 [다음 → 실습](@next)
*/
