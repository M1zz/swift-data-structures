//: [← 개념으로 돌아가기](@previous)
/*:
 # A2 실습 — Binary Search
 아래 TODO를 채워서 직접 구현해보세요.
*/
import Foundation

// ── 실습 1: 회전된 정렬 배열에서 탐색 ──
// [4,5,6,7,0,1,2] 처럼 정렬된 배열이 어느 지점에서 회전되어 있을 때 target을 찾으세요.
// TODO: O(log n)으로 구현하세요.
func searchRotated(_ arr: [Int], _ target: Int) -> Int {
    var lo = 0, hi = arr.count - 1
    while lo <= hi {
        let mid = lo + (hi - lo) / 2
        if arr[mid] == target { return mid }
        // TODO: 어느 쪽이 정렬되어 있는지 판단하여 탐색 범위를 좁히세요
        // Hint: arr[lo] <= arr[mid] 이면 왼쪽이 정렬됨
        lo = mid + 1  // 이 줄을 교체하세요
    }
    return -1
}

print("회전 배열 탐색:")
print(searchRotated([4,5,6,7,0,1,2], 0))   // 4
print(searchRotated([4,5,6,7,0,1,2], 3))   // -1
print(searchRotated([1], 0))               // -1

// ── 실습 2: 제곱근 구하기 (정수) ──
// TODO: Binary Search로 sqrt(n)의 정수 부분을 구하세요. O(log n)
func mySqrt(_ n: Int) -> Int {
    // TODO: 구현하세요
    return -1
}

print("\n제곱근:")
print(mySqrt(4))    // 2
print(mySqrt(8))    // 2 (2.82...의 정수 부분)
print(mySqrt(9))    // 3

// ── 실습 3: 두 배열의 중간값 ──
// TODO: 정렬된 두 배열 nums1, nums2의 중간값(median)을 O(log(m+n))으로 구하세요.
// 이 문제는 LeetCode Hard — Binary Search의 최고 응용입니다.
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    // TODO: 구현하세요 (힌트: 더 짧은 배열에 이진 탐색을 적용)
    // 단순 O(m+n) 풀이도 먼저 작성해보세요
    let merged = (nums1 + nums2).sorted()
    let n = merged.count
    return n % 2 == 0 ? Double(merged[n/2-1] + merged[n/2]) / 2.0 : Double(merged[n/2])
}

print("\n두 배열 중간값:")
print(findMedianSortedArrays([1,3], [2]))       // 2.0
print(findMedianSortedArrays([1,2], [3,4]))     // 2.5

/*:
 ## 도전 과제
 1. **First Bad Version**: 1~n 중 처음 bad version이 되는 번호를 O(log n)으로 구하세요.
 2. **LIS 최적화**: LIS(최장 증가 부분수열)를 Lower Bound를 사용해 O(n log n)으로 구현하세요.

 [다음 → DP 개념](@next)
*/
