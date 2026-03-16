//: [← Back to Concepts](@previous)
/*:
 # A5 실습 — Backtracking
*/
import Foundation

// ── Exercise 1: 스도쿠 풀기 ──
// 0은 빈 칸입니다. Backtracking으로 스도쿠를 완성하세요.
func solveSudoku(_ board: inout [[Int]]) -> Bool {
    for r in 0..<9 { for c in 0..<9 {
        guard board[r][c] == 0 else { continue }
        for num in 1...9 {
            guard isValid(board, r, c, num) else { continue }
            board[r][c] = num
            if solveSudoku(&board) { return true }
            board[r][c] = 0  // Undo
        }
        return false  // 어떤 숫자도 불가 → Backtrack
    }}
    return true
}

func isValid(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
    // 같은 행/열/3x3 박스에 num이 있으면 false
    for i in 0..<9 {
        if board[row][i] == num { return false }
        if board[i][col] == num { return false }
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
    print("Sudoku solution:")
    sudoku.forEach { print($0) }
}

// ── Exercise 2: 부분집합 합 (Subset Sum) ──
// 배열에서 합이 target이 되는 모든 부분집합을 구하세요 (중복 원소 없음, 조합 순서 무관)
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    // TODO: implement. 같은 원소를 여러 번 사용 가능합니다.
    var result: [[Int]] = [], cur: [Int] = []
    let sorted = candidates.sorted()
    func bt(_ start: Int, _ remain: Int) {
        if remain == 0 { result.append(cur); return }
        for i in start..<sorted.count {
            // TODO: Pruning 조건 추가 (remain < sorted[i] → break)
            cur.append(sorted[i])
            bt(i, remain - sorted[i])
            cur.removeLast()
        }
    }
    bt(0, target)
    return result
}

print("\nCombination sum target=7, candidates=[2,3,6,7]:")
print(combinationSum([2,3,6,7], 7))  // [[2,2,3],[7]]

/*:
 ## Challenges
 1. **팰린드롬 분할**: 문자열을 팰린드롬으로만 분할하는 모든 방법
 2. **전화번호 조합**: 숫자 키패드에서 문자 조합 (LeetCode #17)
 3. **Rat in a Maze**: 격자에서 출구까지 모든 경로 찾기

 [다음 → 최단 경로 개념](@next)
*/
