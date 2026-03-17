//: [← Backtracking](@previous)
/*: # Ch.16 — Shortest Path 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 최단 경로 격자 (Shortest Path in Binary Matrix)
// 0은 통과 가능, 1은 막힘. 왼쪽 위에서 오른쪽 아래까지 최단 경로 길이 반환 (8방향)
// 예: [[0,1],[1,0]] → 2
func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
    // TODO: BFS
    return -1
}
assert(shortestPathBinaryMatrix([[0,1],[1,0]]) == 2)
assert(shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,0]]) == 4)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 1에서 N까지 최소 비용 (Cheapest Flights Within K Stops)
// n개 도시, flights 목록, 최대 k번 경유. src → dst 최소 비용 (불가능하면 -1)
func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
    // TODO: Bellman-Ford 변형 (k+1 라운드)
    return -1
}
assert(findCheapestPrice(4, [[0,1,100],[1,2,100],[2,0,100],[1,3,600],[2,3,200]], 0, 3, 1) == 700)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 가중치 그래프에서 경로 최솟값 최소화 (Path With Minimum Effort)
// 격자에서 경로 내 인접 셀 차이의 최댓값을 최소화하는 경로 찾기
func minimumEffortPath(_ heights: [[Int]]) -> Int {
    // TODO: Dijkstra 변형 (최솟값 대신 최대 간선 가중치 최소화)
    return 0
}
assert(minimumEffortPath([[1,2,2],[3,8,2],[5,3,5]]) == 2)
assert(minimumEffortPath([[1,2,3],[3,8,4],[5,3,5]]) == 1)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 도시 분류 (Find the City With the Smallest Number of Reachable Threshold)
// threshold 이하 거리의 이웃 도시 수가 가장 적은 도시를 반환하세요. (Floyd-Warshall)
func findTheCity(_ n: Int, _ edges: [[Int]], _ distanceThreshold: Int) -> Int {
    // TODO: Floyd-Warshall 전체 쌍 최단 경로
    return -1
}
assert(findTheCity(4, [[0,1,3],[1,2,1],[1,3,4],[2,3,1]], 4) == 3)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. K번째 최단 경로 (K-th Shortest Path)
// src → dst 까지 K번째로 짧은 경로의 길이를 반환하세요.
// (같은 노드를 여러 번 방문 가능)
// 예: n=2, edges=[[1,2,1],[1,2,2],[1,2,3]], src=1, dst=2, k=2 → 2
func kthShortestPath(_ n: Int, _ edges: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
    // TODO: Dijkstra + 방문 횟수 카운트 (각 노드를 최대 k번 방문)
    return -1
}
assert(kthShortestPath(2, [[1,2,1],[1,2,2],[1,2,3]], 1, 2, 2) == 2)
print("P5 통과 ✓")
