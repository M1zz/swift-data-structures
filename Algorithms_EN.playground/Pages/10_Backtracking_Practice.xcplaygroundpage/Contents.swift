//: [← 개념으로 돌아가기](@previous)
/*:
 # A5 실습 — Backtracking
*/
import Foundation

// ── 실습 1: 스도쿠 풀기 ──
// 0은 빈 칸입니다. Backtracking으로 스도쿠를 완성합니다.
// 전략: 빈 칸을 순서대로 찾아 1~9를 시도 → 유효하면 채우고 재귀
//        더 이상 채울 수 없으면 되돌린 뒤(Undo) 다음 숫자 시도
func solveSudoku(_ board: inout [[Int]]) -> Bool {
    for r in 0..<9 { for c in 0..<9 {
        guard board[r][c] == 0 else { continue }
        for num in 1...9 {
            guard isValid(board, r, c, num) else { continue }
            board[r][c] = num
            if solveSudoku(&board) { return true }
            board[r][c] = 0  // Undo: 이 숫자로는 해결 불가 → 되돌리기
        }
        return false  // 1~9 모두 실패 → 상위 호출에서 Backtrack
    }}
    return true  // 빈 칸 없음 → 완성
}

// 같은 행/열/3×3 박스에 num이 이미 있으면 false
func isValid(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
    for i in 0..<9 {
        if board[row][i] == num { return false }  // 같은 행
        if board[i][col] == num { return false }  // 같은 열
        // 3×3 박스 내 위치 계산: (row/3)*3 행 블록, (col/3)*3 열 블록의 i번째 셀
        let br = 3*(row/3) + i/3, bc = 3*(col/3) + i%3
        if board[br][bc] == num { return false }
    }
    return true
}

var sudoku = [
    [5,3,0,0,7,0,0,0,0],
    [6,0,0,1,9,5,0,0,0],
    [0,9,8,0,0,0,0,6,0],
    [8,0,0,0,6,0,0,0,3],
    [4,0,0,8,0,3,0,0,1],
    [7,0,0,0,2,0,0,0,6],
    [0,6,0,0,0,0,2,8,0],
    [0,0,0,4,1,9,0,0,5],
    [0,0,0,0,8,0,0,7,9],
]
if solveSudoku(&sudoku) {
    print("스도쿠 풀이:")
    sudoku.forEach { print($0) }
}

// ── 실습 2: 부분집합 합 (Subset Sum / Combination Sum) ──
// 배열에서 합이 target이 되는 모든 부분집합을 구합니다.
// 같은 원소를 여러 번 사용할 수 있고, 중복 조합은 제거합니다.
// 핵심 가지치기(Pruning):
//   - 정렬 후 remain < sorted[i] 이면 이후 원소도 모두 크므로 break
//   - 이 단순한 조건만으로 탐색 공간을 크게 줄일 수 있습니다.
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var result: [[Int]] = [], cur: [Int] = []
    let sorted = candidates.sorted()
    func bt(_ start: Int, _ remain: Int) {
        if remain == 0 { result.append(cur); return }
        for i in start..<sorted.count {
            if remain < sorted[i] { break }  // Pruning: 이후 원소는 모두 크므로 불필요
            cur.append(sorted[i])
            bt(i, remain - sorted[i])  // 같은 인덱스 i 재사용 가능 (중복 허용)
            cur.removeLast()           // Undo: 현재 원소 제거 후 다음 후보 시도
        }
    }
    bt(0, target)
    return result
}

print("\n조합 합 target=7, candidates=[2,3,6,7]:")
print(combinationSum([2,3,6,7], 7))  // [[2,2,3],[7]]

/*:
 ## 도전 과제
 1. **팰린드롬 분할**: 문자열을 팰린드롬으로만 분할하는 모든 방법
 2. **전화번호 조합**: 숫자 키패드에서 문자 조합 (LeetCode #17)
 3. **Rat in a Maze**: 격자에서 출구까지 모든 경로 찾기

 [다음 → 최단 경로 개념](@next)
*/
