/*:
 # Ch.08 — Graph

 ## 핵심 개념: 인접 리스트

 Graph는 **정점(Vertex)**과 **간선(Edge)**으로 이루어진 자료구조입니다.
 표현 방법은 크게 두 가지:

 | 방식 | 공간 | 간선 확인 | 이웃 순회 |
 |------|------|----------|----------|
 | 인접 행렬 | O(V²) | O(1) | O(V) |
 | **인접 리스트** | O(V+E) | O(degree) | O(degree) |

 > 실무에서는 대부분 **인접 리스트**를 사용합니다 (희소 그래프가 대부분).

 ## BFS vs DFS

 | 알고리즘 | 자료구조 | 용도 |
 |---------|---------|------|
 | **BFS** | Queue | 최단 경로 (가중치 없음), 레벨별 탐색 |
 | **DFS** | Stack/재귀 | 사이클 탐지, 위상 정렬, 경로 탐색 |

 ## 시간복잡도

 | 연산 | 복잡도 | 비고 |
 |------|--------|------|
 | BFS / DFS | O(V + E) | 모든 정점, 간선 방문 |
 | 간선 추가 | O(1) | 리스트에 append |
 | 이웃 조회 | O(degree) | 해당 정점의 간선 수 |
 | Dijkstra | O((V+E) log V) | Min-Heap 사용 시 |

 ## 실무에서는?
 - **소셜 네트워크**: 친구 관계 그래프 (Facebook, Instagram)
 - **지도 내비게이션**: 도로 네트워크 + Dijkstra 최단 경로
 - **SPM 의존성 해석**: 패키지 간 의존 관계 → 위상 정렬
 - **추천 시스템**: 유저-아이템 이분 그래프
*/
import Foundation

// ── 인접 리스트 그래프 ──
struct Graph {
    private var adj: [String: [(to: String, weight: Int)]] = [:]

    mutating func addEdge(from: String, to: String, weight: Int = 1, directed: Bool = false) {
        adj[from, default: []].append((to, weight))
        if !directed { adj[to, default: []].append((from, weight)) }
    }

    func neighbors(of v: String) -> [(to: String, weight: Int)] { adj[v] ?? [] }
    var vertices: [String] { Array(adj.keys).sorted() }

    // BFS — 너비 우선 탐색
    func bfs(from start: String) -> [String] {
        var visited: Set<String> = [start]
        var queue: [String] = [start]
        var result: [String] = []
        while !queue.isEmpty {
            let v = queue.removeFirst()
            result.append(v)
            for nb in neighbors(of: v).map(\.to).sorted() {
                if !visited.contains(nb) {
                    visited.insert(nb)
                    queue.append(nb)
                }
            }
        }
        return result
    }

    // DFS — 깊이 우선 탐색
    func dfs(from start: String) -> [String] {
        var visited: Set<String> = []
        var result: [String] = []
        func _dfs(_ v: String) {
            visited.insert(v)
            result.append(v)
            for nb in neighbors(of: v).map(\.to).sorted() {
                if !visited.contains(nb) { _dfs(nb) }
            }
        }
        _dfs(start)
        return result
    }
}

// ── 데모 ──
print("=== Graph: BFS vs DFS ===")
var g = Graph()
//   A ─ B ─ D ─ E
//   |   |
//   C ──┘
g.addEdge(from: "A", to: "B")
g.addEdge(from: "A", to: "C")
g.addEdge(from: "B", to: "C")
g.addEdge(from: "B", to: "D")
g.addEdge(from: "D", to: "E")

print("정점:", g.vertices)
print("BFS from A:", g.bfs(from: "A"))
print("DFS from A:", g.dfs(from: "A"))

// ── BFS로 최단 거리 ──
print("\n=== BFS 최단 거리 (가중치 없음) ===")
func bfsDistance(_ graph: Graph, from start: String) -> [String: Int] {
    var dist: [String: Int] = [start: 0]
    var queue: [String] = [start]
    while !queue.isEmpty {
        let v = queue.removeFirst()
        for nb in graph.neighbors(of: v).map(\.to) {
            if dist[nb] == nil {
                dist[nb] = dist[v]! + 1
                queue.append(nb)
            }
        }
    }
    return dist
}

let distances = bfsDistance(g, from: "A")
for (v, d) in distances.sorted(by: { $0.key < $1.key }) {
    print("  A → \(v): \(d)")
}
/*:
 > BFS는 **가중치가 없는 그래프**에서 최단 경로를 보장합니다.
 > 가중치가 있으면 **Dijkstra** 알고리즘을 사용해야 합니다.

 [다음 → 실습](@next)
*/
