//: [← Back to Concepts](@previous)
/*:
 # A1 실습 — Sorting
 Fill in the TODOs below to implement each exercise.
*/
import Foundation

// ── Exercise 1: Median-of-3 Quick Sort ──
// TODO: pivot을 lo, mid, hi 세 원소의 중간값으로 선택하도록 partition을 수정하세요.
// sorted array에서도 O(n²)이 발생하지 않게 됩니다.
func partition_m3(_ arr: inout [Int], _ lo: Int, _ hi: Int) -> Int {
    // TODO: median-of-3 pivot 선택 로직 작성
    let pivot = arr[hi]  // Replace this line
    var i = lo
    for j in lo..<hi {
        if arr[j] <= pivot { arr.swapAt(i, j); i += 1 }
    }
    arr.swapAt(i, hi)
    return i
}

// ── Exercise 2: stable sort 확인 ──
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

// TODO: grade로 정렬하되, 같은 grade 내에서 원래 순서가 유지되는지 확인하세요
let sorted = students.sorted { $0.grade < $1.grade }
print("stable sort 결과: \(sorted)")
// Expected: [영희(1), 지현(1), 철수(2), 민수(2)] — 같은 grade에서 원래 순서 유지

// ── Exercise 3: k번째 최솟값 (Quick Select) ──
// TODO: Quick Sort의 partition을 응용하여 O(n) average로 k번째 최솟값을 구하세요.
// Hint: partition 후 pivot 위치와 k를 비교하여 한쪽만 재귀
func quickSelect(_ arr: inout [Int], _ lo: Int, _ hi: Int, _ k: Int) -> Int {
    // TODO: implement
    return -1
}

var arr = [7, 2, 5, 1, 9, 3, 8, 4, 6]
// let k3 = quickSelect(&arr, 0, arr.count-1, 2)  // 3번째 최솟값 (0-indexed)
// print("3rd smallest: \(k3)")  // Answer: 3

/*:
 ## Challenges
 1. **Counting Sort**: 값 범위가 0..<k일 때 O(n+k)로 정렬하세요.
 2. **Radix Sort**: 자릿수 기준으로 stable sort을 반복하여 O(nk)로 정렬하세요.
 3. **외부 정렬**: 배열이 메모리에 다 안 들어올 때 Merge Sort를 어떻게 변형할지 설계해보세요.

 [다음 → Binary Search 개념](@next)
*/
