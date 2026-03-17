//: [← 목차](@previous) | [다음 →](@next)
/*: # Ch.01 — Array 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 두 수의 합 (Two Sum)
// 정수 배열 nums와 target이 주어질 때,
// 합이 target이 되는 두 인덱스를 반환하세요.
// 각 입력에 정확히 하나의 답이 존재하고, 같은 원소를 두 번 사용할 수 없습니다.
// 예: nums=[2,7,11,15], target=9 → [0,1]
// 시간 복잡도 목표: O(n)
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    // TODO:
    return []
}
assert(twoSum([2,7,11,15], 9) == [0,1])
assert(twoSum([3,2,4], 6) == [1,2])
assert(twoSum([3,3], 6) == [0,1])
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 최대 연속 부분합 (Maximum Subarray)
// 정수 배열에서 연속된 부분배열의 합 중 최댓값을 반환하세요.
// 예: [-2,1,-3,4,-1,2,1,-5,4] → 6  ([4,-1,2,1])
// 시간 복잡도 목표: O(n)  (Kadane's Algorithm)
func maxSubArray(_ nums: [Int]) -> Int {
    // TODO:
    return 0
}
assert(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6)
assert(maxSubArray([1]) == 1)
assert(maxSubArray([5,4,-1,7,8]) == 23)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 제품 배열 (Product of Array Except Self)
// nums[i]를 제외한 나머지 원소의 곱으로 이루어진 배열을 반환하세요.
// 나눗셈 사용 금지. 시간 O(n), 공간 O(1) 추가공간 목표.
// 예: [1,2,3,4] → [24,12,8,6]
func productExceptSelf(_ nums: [Int]) -> [Int] {
    // TODO:
    return []
}
assert(productExceptSelf([1,2,3,4]) == [24,12,8,6])
assert(productExceptSelf([-1,1,0,-3,3]) == [0,0,9,0,0])
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 컨테이너 물 채우기 (Container With Most Water)
// 높이 배열이 주어질 때 두 라인 사이에 담을 수 있는 최대 물의 양을 반환하세요.
// 예: [1,8,6,2,5,4,8,3,7] → 49
// 시간 복잡도 목표: O(n)  (투 포인터)
func maxWater(_ height: [Int]) -> Int {
    // TODO:
    return 0
}
assert(maxWater([1,8,6,2,5,4,8,3,7]) == 49)
assert(maxWater([1,1]) == 1)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 트래핑 빗물 (Trapping Rain Water)
// 각 칸의 높이가 주어질 때, 빗물이 고이는 총량을 계산하세요.
// 예: [0,1,0,2,1,0,1,3,2,1,2,1] → 6
// 시간 O(n), 공간 O(1) 목표
func trap(_ height: [Int]) -> Int {
    // TODO:
    return 0
}
assert(trap([0,1,0,2,1,0,1,3,2,1,2,1]) == 6)
assert(trap([4,2,0,3,2,5]) == 9)
print("P5 통과 ✓")
