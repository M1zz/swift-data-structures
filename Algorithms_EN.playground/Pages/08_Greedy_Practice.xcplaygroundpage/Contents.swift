//: [← 개념으로 돌아가기](@previous)
/*:
 # A4 실습 — Greedy
*/
import Foundation

// ── 실습 1: 회의실 배정 (최소 회의실 수) ──
// 여러 미팅이 겹칠 때 필요한 최소 회의실 수를 구합니다.
// 전략: 시작 시간 배열과 종료 시간 배열을 각각 정렬한 뒤 두 포인터로 비교합니다.
//   - 현재 미팅의 시작 시간 >= 가장 일찍 끝나는 미팅의 종료 시간
//     → 회의실 재사용 가능 (종료 포인터 전진)
//   - 그렇지 않으면 새 회의실 필요 (rooms 증가)
func minMeetingRooms(_ intervals: [(start: Int, end: Int)]) -> Int {
    guard !intervals.isEmpty else { return 0 }
    let starts = intervals.map { $0.start }.sorted()  // 시작 시간 정렬
    let ends   = intervals.map { $0.end   }.sorted()  // 종료 시간 정렬
    var rooms = 0, endIdx = 0
    for startIdx in 0..<starts.count {
        if starts[startIdx] < ends[endIdx] {
            rooms += 1  // 기존 미팅이 아직 끝나지 않음 → 새 방 필요
        } else {
            endIdx += 1  // 가장 일찍 끝나는 방이 비었음 → 재사용
        }
    }
    return rooms
}

print("최소 회의실 수:")
print(minMeetingRooms([(0,30),(5,10),(15,20)]))  // 2
print(minMeetingRooms([(7,10),(2,4)]))           // 1

// ── 실습 2: 점프 게임 ──
// 배열의 각 원소는 해당 위치에서 최대 점프 거리입니다.
// 첫 번째 원소에서 마지막까지 도달 가능한지 판단합니다.
// 전략: 현재까지 도달 가능한 최대 인덱스(reach)를 관리합니다.
//   - 현재 위치 i가 reach를 넘으면 이미 막혀있으므로 false
//   - 아니면 reach = max(reach, i + nums[i]) 로 갱신
func canJump(_ nums: [Int]) -> Bool {
    var reach = 0  // 현재까지 도달 가능한 최대 인덱스
    for i in 0..<nums.count {
        if i > reach { return false }          // i에 도달 불가 → 탈출
        reach = max(reach, i + nums[i])        // 최대 도달 범위 갱신
        if reach >= nums.count - 1 { return true }  // 마지막 인덱스 도달 가능
    }
    return true
}

print("\n점프 게임:")
print(canJump([2,3,1,1,4]))  // true
print(canJump([3,2,1,0,4]))  // false

// ── 실습 3: 최소 화살로 풍선 터뜨리기 ──
// 풍선 [xstart, xend]들이 있을 때, 수직 화살로 모든 풍선을 터뜨리는 최소 화살 수를 구합니다.
// Activity Selection 변형: 겹치는 풍선들을 한 화살로 처리합니다.
// 전략:
//   1. 종료 위치(end) 기준으로 오름차순 정렬
//   2. 첫 번째 화살을 현재 풍선의 end에 쏜다
//   3. 다음 풍선의 start가 현재 화살 위치보다 크면 새 화살 필요
func findMinArrows(_ points: [[Int]]) -> Int {
    guard !points.isEmpty else { return 0 }
    // end 기준 정렬 → 가장 일찍 끝나는 풍선부터 처리
    let sorted = points.sorted { $0[1] < $1[1] }
    var arrows = 1
    var arrowPos = sorted[0][1]  // 첫 화살의 위치 = 첫 풍선의 end
    for i in 1..<sorted.count {
        if sorted[i][0] > arrowPos {
            // 현재 화살로 이 풍선을 터뜨릴 수 없음 → 새 화살 발사
            arrows += 1
            arrowPos = sorted[i][1]  // 새 화살 위치 = 이 풍선의 end
        }
        // sorted[i][0] <= arrowPos 이면 현재 화살로 동시에 터짐 → 추가 불필요
    }
    return arrows
}

print("\n최소 화살:")
print(findMinArrows([[10,16],[2,8],[1,6],[7,12]]))   // 2
print(findMinArrows([[1,2],[3,4],[5,6],[7,8]]))       // 4
print(findMinArrows([[1,2],[2,3],[3,4],[4,5]]))       // 2

/*:
 ## 도전 과제
 1. **Task Scheduler**: CPU 작업 스케줄링 — 같은 작업 사이 n 간격 필요할 때 최소 시간
 2. **Lemonade Change**: 거스름돈 문제 — Greedy로 가능한지 판단
 3. **Huffman Coding**: 빈도 배열로 Huffman 트리를 만들고 최적 코드 길이 합 계산

 [다음 → Backtracking 개념](@next)
*/
