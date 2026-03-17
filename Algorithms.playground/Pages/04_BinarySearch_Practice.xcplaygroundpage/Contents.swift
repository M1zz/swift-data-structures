//: [← 개념으로 돌아가기](@previous)
/*:
 # A2 실습 — Binary Search
 아래 TODO를 채워서 직접 구현해보세요.
*/
import Foundation

// ── 실습 1: 회전된 정렬 배열에서 탐색 ──
// [4,5,6,7,0,1,2] 처럼 정렬된 배열이 어느 지점에서 회전되어 있을 때 target을 찾습니다.
// 핵심 관찰: mid를 기준으로 왼쪽 또는 오른쪽 중 한 쪽은 반드시 정렬되어 있다.
// → 정렬된 쪽에 target이 들어오면 그쪽으로, 아니면 반대쪽으로 범위를 좁힌다.
func searchRotated(_ arr: [Int], _ target: Int) -> Int {
    var lo = 0, hi = arr.count - 1
    while lo <= hi {
        let mid = lo + (hi - lo) / 2
        if arr[mid] == target { return mid }

        // 왼쪽 절반이 정렬되어 있는 경우 (arr[lo] ≤ arr[mid])
        if arr[lo] <= arr[mid] {
            // target이 정렬된 왼쪽 범위 안에 있으면 왼쪽으로 좁힌다
            if arr[lo] <= target && target < arr[mid] {
                hi = mid - 1
            } else {
                lo = mid + 1  // 아니면 오른쪽 탐색
            }
        } else {
            // 오른쪽 절반이 정렬되어 있는 경우 (arr[mid] < arr[hi])
            // target이 정렬된 오른쪽 범위 안에 있으면 오른쪽으로 좁힌다
            if arr[mid] < target && target <= arr[hi] {
                lo = mid + 1
            } else {
                hi = mid - 1  // 아니면 왼쪽 탐색
            }
        }
    }
    return -1
}

print("회전 배열 탐색:")
print(searchRotated([4,5,6,7,0,1,2], 0))   // 4
print(searchRotated([4,5,6,7,0,1,2], 3))   // -1
print(searchRotated([1], 0))               // -1

// ── 실습 2: 제곱근 구하기 (정수) ──
// Binary Search로 sqrt(n)의 정수 부분을 구합니다. O(log n)
// 탐색 범위: 0 ~ n/2 (n ≥ 2일 때 sqrt(n) ≤ n/2)
// mid*mid ≤ n이면 후보로 기록하고 오른쪽 탐색, 크면 왼쪽 탐색
func mySqrt(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    var lo = 1, hi = n / 2 + 1  // +1: n=1일 때 hi가 1 이상이 되도록
    var result = 0
    while lo <= hi {
        let mid = lo + (hi - lo) / 2
        if mid * mid <= n {
            result = mid   // mid가 유효한 후보 → 더 큰 값 탐색
            lo = mid + 1
        } else {
            hi = mid - 1   // mid*mid > n → 너무 크므로 줄인다
        }
    }
    return result
}

print("\n제곱근:")
print(mySqrt(4))    // 2
print(mySqrt(8))    // 2 (2.82...의 정수 부분)
print(mySqrt(9))    // 3

// ── 실습 3: 두 배열의 중간값 ──
// 정렬된 두 배열 nums1, nums2의 중간값(median)을 O(log(m+n))으로 구합니다.
// 전략: 더 짧은 배열(nums1)에 이진 탐색을 적용해 "분할 위치"를 찾는다.
//   - 전체 절반 = (m + n + 1) / 2
//   - nums1을 i개, nums2를 j = half - i개 왼쪽에 두었을 때
//     maxLeft1 ≤ minRight2  AND  maxLeft2 ≤ minRight1 이 되는 i를 찾는다.
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var a = nums1, b = nums2
    // a가 항상 더 짧은 배열이 되도록 교환
    if a.count > b.count { swap(&a, &b) }

    let m = a.count, n = b.count
    let half = (m + n + 1) / 2  // 왼쪽 파티션에 들어갈 원소 수

    var lo = 0, hi = m
    while lo <= hi {
        let i = lo + (hi - lo) / 2  // a에서 왼쪽 파티션에 넣을 개수
        let j = half - i            // b에서 왼쪽 파티션에 넣을 개수

        // 경계를 넘을 경우 ±∞로 처리
        let maxLeft1  = i == 0 ? Int.min : a[i - 1]
        let minRight1 = i == m ? Int.max : a[i]
        let maxLeft2  = j == 0 ? Int.min : b[j - 1]
        let minRight2 = j == n ? Int.max : b[j]

        if maxLeft1 <= minRight2 && maxLeft2 <= minRight1 {
            // 올바른 분할 위치를 찾음
            let maxLeft  = max(maxLeft1, maxLeft2)
            let minRight = min(minRight1, minRight2)
            if (m + n) % 2 == 1 {
                return Double(maxLeft)   // 홀수: 왼쪽 파티션의 최댓값
            } else {
                return Double(maxLeft + minRight) / 2.0  // 짝수: 경계 두 값의 평균
            }
        } else if maxLeft1 > minRight2 {
            hi = i - 1   // a의 왼쪽 파티션이 너무 큼 → i 줄이기
        } else {
            lo = i + 1   // a의 왼쪽 파티션이 너무 작음 → i 늘리기
        }
    }
    // 입력이 올바른 정렬 배열이라면 여기 도달하지 않음
    return 0.0
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
