//: [← DP](@previous) | [다음 →](@next)
/*: # Ch.14 — Greedy 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 분배 사탕 (Assign Cookies)
// 아이들의 욕구(g)와 쿠키 크기(s)가 주어질 때 만족시킬 수 있는 최대 아이 수
// 예: g=[1,2,3], s=[1,1] → 1
func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
    // TODO: 정렬 후 투 포인터
    return 0
}
assert(findContentChildren([1,2,3], [1,1]) == 1)
assert(findContentChildren([1,2], [1,2,3]) == 2)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 점프 게임 II (Jump Game II - 최소 점프 수)
// 마지막 인덱스까지 도달하는 최소 점프 횟수를 반환하세요.
// 예: [2,3,1,1,4] → 2
func jump(_ nums: [Int]) -> Int {
    // TODO: Greedy — 현재 범위 내 최대 도달 거리 탐색
    return 0
}
assert(jump([2,3,1,1,4]) == 2)
assert(jump([2,3,0,1,4]) == 2)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 주유소 (Gas Station)
// n개 주유소를 순환할 때 완주 가능한 시작 인덱스를 반환 (불가능하면 -1)
// 예: gas=[1,2,3,4,5], cost=[3,4,5,1,2] → 3
func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
    // TODO: total sum >= 0 이면 반드시 하나의 해가 존재
    return -1
}
assert(canCompleteCircuit([1,2,3,4,5], [3,4,5,1,2]) == 3)
assert(canCompleteCircuit([2,3,4], [3,4,3]) == -1)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. Task Scheduler
// CPU 작업 배열 tasks와 냉각 시간 n이 주어질 때 최소 시간 단위를 반환하세요.
// 예: tasks=["A","A","A","B","B","B"], n=2 → 8
func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
    // TODO: 가장 빈도 높은 작업 기준으로 계산
    return 0
}
assert(leastInterval(["A","A","A","B","B","B"], 2) == 8)
assert(leastInterval(["A","A","A","A","A","A","B","C","D","E","F","G"], 2) == 16)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 회의 참가 최대화 (Maximum Meetings in a Day)
// 회의 start[], end[] 배열이 주어질 때 참가할 수 있는 최대 회의 수
// (Activity Selection Problem)
// 예: start=[1,3,0,5,8,5], end=[2,4,6,7,9,9] → 4
func maxMeetings(_ start: [Int], _ end: [Int]) -> Int {
    // TODO: 종료 시간 기준 정렬 후 Greedy
    return 0
}
assert(maxMeetings([1,3,0,5,8,5], [2,4,6,7,9,9]) == 4)
print("P5 통과 ✓")
