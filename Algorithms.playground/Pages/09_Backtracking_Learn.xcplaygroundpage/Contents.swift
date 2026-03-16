//: [← Greedy 실습](@previous)
/*:
 # A5 — Backtracking

 ## 핵심 패턴

 ```
 선택(Choose) → 제약 확인(Constrain) → 재귀(Explore) → 선택 취소(Unchoose)
 ```

 상태를 선택 전으로 되돌리는 **Undo** 가 핵심입니다.

 ## Pruning (가지치기)

 해가 될 수 없는 경우를 조기에 포기합니다.
 최악 시간복잡도는 완전 탐색과 같지만 Pruning이 효과적이면 실제 탐색 공간이 급격히 줄어듭니다.

 ## 4가지 조합 유형

 | 유형 | 중복 허용 | 순서 구분 | 예시 |
 |------|----------|----------|------|
 | 조합 | ✗ | ✗ | nCr |
 | 순열 | ✗ | ✓ | nPr |
 | 중복 조합 | ✓ | ✗ | 동전 거스름돈 |
 | 중복 순열 | ✓ | ✓ | 비밀번호 |

 ## 실무에서는?
 - **정규식 엔진**: NFA 상태 탐색
 - **스도쿠 풀이**: 앱 기능 구현
 - **체스 엔진**: 최적 수 탐색 (with Alpha-Beta Pruning)
*/
import Foundation

// ── N-Queens ──
func solveNQueens(_ n: Int) -> Int {
    var cols = Set<Int>(), diag1 = Set<Int>(), diag2 = Set<Int>()
    var count = 0

    func bt(_ row: Int) {
        if row == n { count += 1; return }
        for col in 0..<n {
            guard !cols.contains(col),
                  !diag1.contains(row - col),
                  !diag2.contains(row + col) else { continue }
            // 선택
            cols.insert(col); diag1.insert(row-col); diag2.insert(row+col)
            bt(row + 1)
            // 취소
            cols.remove(col); diag1.remove(row-col); diag2.remove(row+col)
        }
    }
    bt(0)
    return count
}

for n in 1...8 {
    print("N=\(n): \(solveNQueens(n))가지")
}

// ── 순열 / 조합 ──
func permutations(_ nums: [Int]) -> [[Int]] {
    var result: [[Int]] = [], cur: [Int] = [], used = Array(repeating: false, count: nums.count)
    func bt() {
        if cur.count == nums.count { result.append(cur); return }
        for i in 0..<nums.count {
            guard !used[i] else { continue }
            used[i] = true;  cur.append(nums[i])
            bt()
            used[i] = false; cur.removeLast()
        }
    }
    bt(); return result
}

func combinations(_ nums: [Int], _ k: Int) -> [[Int]] {
    var result: [[Int]] = [], cur: [Int] = []
    func bt(_ start: Int) {
        if cur.count == k { result.append(cur); return }
        for i in start..<nums.count {
            cur.append(nums[i]); bt(i + 1); cur.removeLast()
        }
    }
    bt(0); return result
}

print("\n순열 [1,2,3]: \(permutations([1,2,3]).count)가지")    // 6
print("조합 C(4,2): \(combinations([1,2,3,4], 2).count)가지") // 6

// ── 단어 검색 (Word Search) ──
func wordSearch(_ board: [[Character]], _ word: String) -> Bool {
    let rows = board.count, cols = board[0].count
    let word = Array(word)
    var board = board

    func bt(_ r: Int, _ c: Int, _ idx: Int) -> Bool {
        if idx == word.count { return true }
        guard (0..<rows).contains(r), (0..<cols).contains(c),
              board[r][c] == word[idx] else { return false }
        let tmp = board[r][c]
        board[r][c] = "#"  // 방문 표시
        let found = bt(r+1,c,idx+1) || bt(r-1,c,idx+1) || bt(r,c+1,idx+1) || bt(r,c-1,idx+1)
        board[r][c] = tmp  // 복원
        return found
    }

    for r in 0..<rows { for c in 0..<cols { if bt(r, c, 0) { return true } } }
    return false
}

let board: [[Character]] = [["A","B","C","E"],
                              ["S","F","C","S"],
                              ["A","D","E","E"]]
print("\n단어 탐색 ABCCED: \(wordSearch(board, "ABCCED"))")  // true
print("단어 탐색 SEE:    \(wordSearch(board, "SEE"))")      // true
print("단어 탐색 ABCB:   \(wordSearch(board, "ABCB"))")     // false

/*:
 [다음 → 실습](@next)
*/
