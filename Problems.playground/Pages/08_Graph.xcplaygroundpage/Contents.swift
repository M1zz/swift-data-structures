//: [← Heap](@previous) | [다음 →](@next)
/*: # Ch.08 — Graph 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 섬의 개수 (Number of Islands)
// '1'은 땅, '0'은 물. DFS/BFS로 섬의 개수를 세세요.
// 예: [["1","1","0"],["0","1","0"],["0","0","1"]] → 2
func numIslands(_ grid: [[Character]]) -> Int {
    // TODO:
    return 0
}
assert(numIslands([["1","1","0","0","0"],["1","1","0","0","0"],["0","0","1","0","0"],["0","0","0","1","1"]]) == 3)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 코스 수강 가능 여부 (Course Schedule)
// numCourses개 강의, prerequisites[i]=[a,b]는 b를 들어야 a를 들을 수 있음.
// 모든 강의를 완료할 수 있으면 true (= 사이클이 없으면 true)
func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    // TODO: 위상 정렬 또는 DFS로 사이클 감지
    return false
}
assert(canFinish(2, [[1,0]]) == true)
assert(canFinish(2, [[1,0],[0,1]]) == false)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 네트워크 연결 요소 수 (Number of Connected Components)
// n개 노드, edges 목록에서 연결된 컴포넌트 수를 반환하세요.
// 힌트: Union-Find 또는 DFS
func countComponents(_ n: Int, _ edges: [[Int]]) -> Int {
    // TODO:
    return 0
}
assert(countComponents(5, [[0,1],[1,2],[3,4]]) == 2)
assert(countComponents(5, [[0,1],[1,2],[2,3],[3,4]]) == 1)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 단어 사다리 (Word Ladder)
// beginWord에서 endWord까지, 한 번에 한 글자씩 바꿔 wordList 내 단어만 경유할 때 최단 변환 횟수
// 예: begin="hit", end="cog", list=["hot","dot","dog","lot","log","cog"] → 5
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    // TODO: BFS
    return 0
}
assert(ladderLength("hit","cog",["hot","dot","dog","lot","log","cog"]) == 5)
assert(ladderLength("hit","cog",["hot","dot","dog","lot","log"]) == 0)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 외계 언어 사전 순서 (Alien Dictionary)
// 단어 목록이 외계어 사전 순서대로 정렬되어 있을 때, 알파벳 순서를 위상 정렬로 복원하세요.
// 예: ["wrt","wrf","er","ett","rftt"] → "wertf"
func alienOrder(_ words: [String]) -> String {
    // TODO: 위상 정렬 (Kahn's algorithm)
    return ""
}
assert(alienOrder(["wrt","wrf","er","ett","rftt"]) == "wertf")
print("P5 통과 ✓")
