//: [← Back to Concepts](@previous)
/*:
 # A4 실습 — Greedy
*/
import Foundation

// ── Exercise 1: 회의실 배정 (최소 회의실 수) ──
// 여러 미팅이 겹칠 때 필요한 최소 회의실 수를 구하세요.
// Hint: 시작 시간과 종료 시간을 각각 정렬한 뒤 비교하세요. O(n log n)
func minMeetingRooms(_ intervals: [(start: Int, end: Int)]) -> Int {
    // TODO: implement
    return -1
}

print("Min meeting rooms:")
print(minMeetingRooms([(0,30),(5,10),(15,20)]))  // 2
print(minMeetingRooms([(7,10),(2,4)]))           // 1

// ── Exercise 2: 점프 게임 ──
// 배열의 각 원소는 해당 위치에서 최대 점프 거리입니다.
// 첫 번째 원소에서 마지막까지 도달 가능한지 판단하세요.
func canJump(_ nums: [Int]) -> Bool {
    // TODO: Greedy로 O(n) implement.
    // Hint: 현재까지 도달 가능한 최대 인덱스를 추적
    return false
}

print("\nJump game:")
print(canJump([2,3,1,1,4]))  // true
print(canJump([3,2,1,0,4]))  // false

// ── Exercise 3: 최소 화살로 풍선 터뜨리기 ──
// 풍선 [xstart, xend]들이 있을 때, 수직 화살로 모든 풍선을 터뜨리는 최소 화살 수
func findMinArrows(_ points: [[Int]]) -> Int {
    // TODO: Activity Selection 변형 문제입니다
    return -1
}

print("\nMin arrows:")
print(findMinArrows([[10,16],[2,8],[1,6],[7,12]]))   // 2
print(findMinArrows([[1,2],[3,4],[5,6],[7,8]]))       // 4
print(findMinArrows([[1,2],[2,3],[3,4],[4,5]]))       // 2

/*:
 ## Challenges
 1. **Task Scheduler**: CPU task scheduling — 같은 작업 사이 n 간격 필요할 때 최소 시간
 2. **Lemonade Change**: 거스름돈 문제 — Greedy로 가능한지 판단
 3. **Huffman Coding**: 빈도 배열로 Huffman 트리를 만들고 최적 코드 길이 합 계산

 [다음 → Backtracking 개념](@next)
*/
