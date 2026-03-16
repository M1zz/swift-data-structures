//: [← Back to Concepts](@previous)
/*:
 # Ch.08 Practice — Graph

 인접 리스트 그래프를 직접 구현하고, BFS/DFS를 작성해보세요.
*/
import Foundation

// ── Helper ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── Exercise 1: Graph 구현 ──
struct Graph {
    private var adj: [String: [(to: String, weight: Int)]] = [:]

    // TODO: 간선 추가 (무방향 그래프)
    mutating func addEdge(from: String, to: String, weight: Int = 1, directed: Bool = false) {
        adj[from, default: []].append((to, weight))
        if !directed { adj[to, default: []].append((from, weight)) }
    }

    func neighbors(of v: String) -> [(to: String, weight: Int)] { adj[v] ?? [] }
    var vertices: [String] { Array(adj.keys).sorted() }

    // TODO: BFS 구현
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

    // TODO: DFS 구현
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

// ── Test ──
divider("Graph 기본")
var g = Graph()
for (f, t, w) in [("A","B",1), ("A","C",4), ("B","C",2), ("B","D",5), ("C","D",1), ("D","E",3)] {
    g.addEdge(from: f, to: t, weight: w)
}
print("정점:", g.vertices)
print("BFS from A:", g.bfs(from: "A"))
print("DFS from A:", g.dfs(from: "A"))

// ── Exercise 2: BFS 최단 거리 ──
divider("BFS 최단 거리")

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
    print("  A → \(v): \(d)칸")
}

// ── Exercise 3: 최단 경로 개수 ──
divider("최단 경로 개수")

// TODO: start에서 각 정점까지의 최단 경로 개수를 구하세요
func shortestPathCount(_ graph: Graph, from start: String) -> [String: Int] {
    var dist: [String: Int] = [start: 0]
    var pathCount: [String: Int] = [start: 1]
    var queue: [String] = [start]
    while !queue.isEmpty {
        let v = queue.removeFirst()
        for nb in graph.neighbors(of: v).map(\.to) {
            if dist[nb] == nil {
                dist[nb] = dist[v]! + 1
                pathCount[nb] = pathCount[v]!
                queue.append(nb)
            } else if dist[nb] == dist[v]! + 1 {
                pathCount[nb]! += pathCount[v]!
            }
        }
    }
    return pathCount
}

let counts = shortestPathCount(g, from: "A")
for (v, c) in counts.sorted(by: { $0.key < $1.key }) {
    print("  A → \(v): \(c)개의 최단 경로")
}

/*:
 ## Challenges
 1. **사이클 탐지**: DFS로 무방향 그래프에서 사이클이 있는지 verify
 2. **Dijkstra**: Min-Heap을 사용해 가중치 그래프의 최단 경로를 구해보세요
 3. **위상 정렬**: 방향 그래프에서 의존 관계 순서를 구해보세요
*/
