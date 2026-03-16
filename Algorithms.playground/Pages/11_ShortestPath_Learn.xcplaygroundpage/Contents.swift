//: [← Backtracking 실습](@previous)
/*:
 # A6 — 최단 경로

 ## 세 알고리즘 비교

 | 알고리즘 | 시간 | 음수 가중치 | 음수 사이클 | 용도 |
 |----------|------|------------|------------|------|
 | Dijkstra | O((V+E) log V) | ✗ | ✗ | 단일 출발 |
 | Bellman-Ford | O(VE) | ✓ | 감지 ✓ | 단일 출발 |
 | Floyd-Warshall | O(V³) | ✓ | 감지 ✓ | 모든 쌍 |

 ## Dijkstra

 **탐욕적(Greedy)** 알고리즘입니다. Min Heap으로 가장 가까운 미방문 노드를 선택합니다.
 음수 간선이 없어야 성립합니다. (음수가 있으면 이미 확정된 거리가 갱신될 수 있음)

 ## Bellman-Ford

 모든 간선을 **V-1번** Relax합니다. V번째도 갱신된다면 음수 사이클이 존재합니다.
 느리지만 음수 가중치, 음수 사이클 감지 모두 가능합니다.

 ## Floyd-Warshall

 **중간 노드 k를 경유하는 경우**를 순차적으로 고려합니다.
 `dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j])`

 ## 실무에서는?
 - **내비게이션 앱**: Dijkstra + A* (휴리스틱으로 속도 향상)
 - **라우팅 프로토콜**: OSPF(Dijkstra), RIP(Bellman-Ford)
 - **게임 AI**: A* 알고리즘으로 최단 경로 탐색
*/
import Foundation

typealias Edge = (to: Int, w: Int)

// ── Dijkstra ──
func dijkstra(_ graph: [[Edge]], _ start: Int) -> [Int] {
    let n = graph.count
    var dist = Array(repeating: Int.max, count: n)
    dist[start] = 0
    // (거리, 노드) — 실제 구현에서는 MinHeap 사용
    var heap = [(d: Int, node: Int)]()
    heap.append((0, start))

    while !heap.isEmpty {
        heap.sort { $0.d < $1.d }
        let (d, u) = heap.removeFirst()
        if d > dist[u] { continue }  // 이미 처리된 노드
        for (v, w) in graph[u] {
            let nd = dist[u] + w
            if nd < dist[v] { dist[v] = nd; heap.append((nd, v)) }
        }
    }
    return dist
}

let dijkGraph: [[Edge]] = [
    [(1, 4), (2, 1)],      // 0
    [(3, 1)],              // 1
    [(1, 2), (3, 5)],      // 2
    []                     // 3
]
let dijkResult = dijkstra(dijkGraph, 0)
print("Dijkstra from 0: \(dijkResult)")  // [0, 3, 1, 4]

// ── Bellman-Ford ──
func bellmanFord(n: Int, edges: [(u: Int, v: Int, w: Int)], start: Int) -> [Int]? {
    var dist = Array(repeating: Int.max / 2, count: n)
    dist[start] = 0
    for _ in 0..<n-1 {
        for e in edges {
            if dist[e.u] + e.w < dist[e.v] { dist[e.v] = dist[e.u] + e.w }
        }
    }
    // 음수 사이클 감지
    for e in edges {
        if dist[e.u] + e.w < dist[e.v] { return nil }  // 음수 사이클 존재
    }
    return dist
}

let bfEdges = [(0,1,4),(0,2,1),(2,1,2),(1,3,1),(2,3,5)]
    .map { (u: $0.0, v: $0.1, w: $0.2) }
if let bfResult = bellmanFord(n: 4, edges: bfEdges, start: 0) {
    print("Bellman-Ford from 0: \(bfResult)")  // [0, 3, 1, 4]
}

// ── Floyd-Warshall ──
func floydWarshall(n: Int, edges: [(u: Int, v: Int, w: Int)]) -> [[Int]] {
    var dp = Array(repeating: Array(repeating: Int.max/2, count: n), count: n)
    for i in 0..<n { dp[i][i] = 0 }
    for e in edges { dp[e.u][e.v] = e.w }

    for k in 0..<n { for i in 0..<n { for j in 0..<n {
        dp[i][j] = min(dp[i][j], dp[i][k] + dp[k][j])
    }}}
    return dp
}

let fwResult = floydWarshall(n: 4, edges: bfEdges)
print("\nFloyd-Warshall 전체 쌍:")
fwResult.enumerated().forEach { i, row in
    print("  \(i) → \(row.map { $0 == Int.max/2 ? "∞" : String($0) })")
}

/*:
 [다음 → 실습](@next)
*/
