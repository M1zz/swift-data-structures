//: [← 개념으로 돌아가기](@previous)
/*:
 # A6 실습 — 최단 경로
*/
import Foundation

typealias Edge = (to: Int, w: Int)

// ── 실습 1: 네트워크 지연 시간 ──
// n개 노드, 방향 가중치 간선이 주어질 때 노드 k에서 출발해
// 모든 노드에 신호가 도달하는 최소 시간을 구하세요. 불가능하면 -1 반환.
func networkDelayTime(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
    // TODO: Dijkstra로 구현하세요.
    // times[i] = [ui, vi, wi] (ui→vi, 가중치 wi)
    return -1
}

print("네트워크 지연:")
print(networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))  // 2
print(networkDelayTime([[1,2,1]], 2, 1))                   // 1
print(networkDelayTime([[1,2,1]], 2, 2))                   // -1

// ── 실습 2: 음수 사이클 감지 ──
// 주어진 그래프에 음수 사이클이 있는지 Bellman-Ford로 판단하세요.
func hasNegativeCycle(n: Int, edges: [(u: Int, v: Int, w: Int)]) -> Bool {
    // TODO: 구현하세요
    return false
}

let edgesOk  = [(0,1,4),(1,2,-2),(2,3,3)].map { (u:$0.0,v:$0.1,w:$0.2) }
let edgesBad = [(0,1,1),(1,2,-3),(2,0,1)].map { (u:$0.0,v:$0.1,w:$0.2) }
print("\n음수 사이클:")
print(hasNegativeCycle(n: 4, edges: edgesOk))   // false
print(hasNegativeCycle(n: 3, edges: edgesBad))  // true (1→2→0→1: 1-3+1=-1)

// ── 실습 3: 도시 간 최단 경로 (Floyd-Warshall 응용) ──
// n개 도시의 도로망에서 임의의 두 도시 사이 최단 경로를 모두 구하세요.
// 단, 경유 도시 수가 k 이하인 경로만 허용합니다.
func shortestPathAtMostK(n: Int, edges: [[Int]], src: Int, dst: Int, k: Int) -> Int {
    // TODO: Bellman-Ford 변형으로 구현하세요.
    // 힌트: dp[i][v] = 정확히 i번의 간선을 사용했을 때 src→v 최솟값
    return -1
}

print("\nK 이하 경유:")
print(shortestPathAtMostK(n:4, edges:[[0,1,100],[1,2,100],[0,2,500]], src:0, dst:2, k:1))  // 200
print(shortestPathAtMostK(n:4, edges:[[0,1,100],[1,2,100],[0,2,500]], src:0, dst:2, k:0))  // 500

/*:
 ## 도전 과제
 1. **A* 알고리즘**: Dijkstra에 휴리스틱 함수를 추가하여 탐색 공간을 줄여보세요.
    - 맨해튼 거리 또는 유클리드 거리를 휴리스틱으로 사용
 2. **단어 사다리 (Word Ladder)**: BFS로 단어를 한 글자씩 바꿔 target 단어까지 최단 변환 횟수
 3. **Topological Sort**: DAG에서 위상 정렬 후 최장 경로 구하기 (DP 결합)
*/
