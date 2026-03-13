//: # Ch.08 — Graph
//: 인접행렬 vs 인접리스트 구현 + BFS/DFS.
import Foundation

//: ## 인접리스트 그래프
struct Graph {
    private var adj: [String: [(to: String, weight: Int)]] = [:]

    mutating func addEdge(from: String, to: String, weight: Int = 1, directed: Bool = false) {
        adj[from, default: []].append((to, weight))
        if !directed { adj[to, default: []].append((from, weight)) }
    }

    func neighbors(of v: String) -> [(to: String, weight: Int)] { adj[v] ?? [] }
    var vertices: [String] { Array(adj.keys).sorted() }

    // BFS — 최단 경로 (가중치 없을 때)
    func bfs(from start: String) -> [String] {
        var visited: Set<String> = [start]
        var queue: [String] = [start]
        var result: [String] = []
        while !queue.isEmpty {
            let v = queue.removeFirst()
            result.append(v)
            for nb in neighbors(of: v).map(\.to) {
                if !visited.contains(nb) { visited.insert(nb); queue.append(nb) }
            }
        }
        return result
    }

    // DFS — 재귀
    func dfs(from start: String) -> [String] {
        var visited: Set<String> = []
        var result: [String] = []
        func _dfs(_ v: String) {
            visited.insert(v); result.append(v)
            for nb in neighbors(of: v).map(\.to) {
                if !visited.contains(nb) { _dfs(nb) }
            }
        }
        _dfs(start); return result
    }

    // 다익스트라 최단 경로
    func dijkstra(from start: String) -> [String: Int] {
        var dist: [String: Int] = [start: 0]
        var visited: Set<String> = []
        var heap = Heap<(dist: Int, v: String)> { $0.dist < $1.dist }
        heap.insert((0, start))
        while let (d, v) = heap.remove() {
            if visited.contains(v) { continue }
            visited.insert(v)
            for nb in neighbors(of: v) {
                let newDist = d + nb.weight
                if newDist < (dist[nb.to] ?? Int.max) {
                    dist[nb.to] = newDist
                    heap.insert((newDist, nb.to))
                }
            }
        }
        return dist
    }
}

// Heap for Dijkstra
struct Heap<T> {
    private var els: [T]; private let cmp: (T,T)->Bool
    init(_ cmp: @escaping (T,T)->Bool){els=[];self.cmp=cmp}
    var isEmpty:Bool{els.isEmpty}
    mutating func insert(_ v:T){els.append(v);siftUp(els.count-1)}
    mutating func remove()->T?{
        guard !isEmpty else{return nil}
        els.swapAt(0,els.count-1);let r=els.removeLast()
        if !isEmpty{siftDown(0)};return r}
    private mutating func siftUp(_ i:Int){
        var c=i;while c>0{let p=(c-1)/2;guard cmp(els[c],els[p])else{break};els.swapAt(c,p);c=p}}
    private mutating func siftDown(_ i:Int){
        var p=i;while true{let l=2*p+1,r=2*p+2;var best=p
            if l<els.count&&cmp(els[l],els[best]){best=l}
            if r<els.count&&cmp(els[r],els[best]){best=r}
            if best==p{break};els.swapAt(p,best);p=best}}
}

print("=== Graph 실습 ===")
var g = Graph()
for (f,t,w) in [("A","B",1),("A","C",4),("B","C",2),("B","D",5),("C","D",1),("D","E",3)] {
    g.addEdge(from: f, to: t, weight: w)
}
print("BFS from A:", g.bfs(from: "A"))
print("DFS from A:", g.dfs(from: "A"))

print("\n다익스트라 최단거리 from A:")
g.dijkstra(from: "A").sorted(by:{$0.key<$1.key}).forEach {
    print("  A →", $0.key, ":", $0.value)
}
//: 실습: 그래프에서 사이클을 탐지하는 함수를 작성해보세요.
