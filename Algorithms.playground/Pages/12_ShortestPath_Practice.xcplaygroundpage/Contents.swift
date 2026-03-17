//: [← 개념으로 돌아가기](@previous)
/*:
 # A6 실습 — 최단 경로
*/
import Foundation

typealias Edge = (to: Int, w: Int)

// ── 실습 1: 네트워크 지연 시간 ──
// n개 노드, 방향 가중치 간선이 주어질 때 노드 k에서 출발해
// 모든 노드에 신호가 도달하는 최소 시간을 구합니다. 불가능하면 -1 반환.
// 전략: Dijkstra — Min Heap 대신 단순 정렬로 구현합니다.
//   1. k에서 시작해 dist 배열 초기화 (k=0, 나머지=∞)
//   2. 아직 방문하지 않은 노드 중 dist가 가장 작은 노드 선택
//   3. 해당 노드의 인접 간선을 완화(Relax)
//   4. 최종 dist 배열에서 최댓값이 정답 (미방문 노드가 있으면 -1)
func networkDelayTime(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
    // 인접 리스트 구성 (1-indexed → 0-indexed)
    var graph = Array(repeating: [(to: Int, w: Int)](), count: n)
    for t in times {
        graph[t[0] - 1].append((to: t[1] - 1, w: t[2]))
    }

    var dist = Array(repeating: Int.max, count: n)
    dist[k - 1] = 0
    // (거리, 노드) 쌍 — 실제 서비스에서는 MinHeap(우선순위 큐) 사용 권장
    var heap = [(d: Int, node: Int)]()
    heap.append((0, k - 1))

    while !heap.isEmpty {
        heap.sort { $0.d < $1.d }
        let (d, u) = heap.removeFirst()
        if d > dist[u] { continue }  // 이미 더 짧은 경로로 처리된 노드 → 스킵
        for (v, w) in graph[u] {
            let nd = dist[u] + w
            if nd < dist[v] {
                dist[v] = nd         // 더 짧은 경로 발견 → 갱신
                heap.append((nd, v))
            }
        }
    }

    let maxDist = dist.max()!
    return maxDist == Int.max ? -1 : maxDist  // 미방문 노드가 있으면 -1
}

print("네트워크 지연:")
print(networkDelayTime([[2,1,1],[2,3,1],[3,4,1]], 4, 2))  // 2
print(networkDelayTime([[1,2,1]], 2, 1))                   // 1
print(networkDelayTime([[1,2,1]], 2, 2))                   // -1

// ── 실습 2: 음수 사이클 감지 ──
// 주어진 그래프에 음수 사이클이 있는지 Bellman-Ford로 판단합니다.
// 전략: 모든 간선을 V-1번 완화(Relax)한 뒤
//        V번째에도 거리가 줄어드는 간선이 있으면 → 음수 사이클 존재
func hasNegativeCycle(n: Int, edges: [(u: Int, v: Int, w: Int)]) -> Bool {
    var dist = Array(repeating: Int.max / 2, count: n)
    dist[0] = 0

    // V-1번 모든 간선 완화
    for _ in 0..<n - 1 {
        for e in edges {
            if dist[e.u] + e.w < dist[e.v] {
                dist[e.v] = dist[e.u] + e.w
            }
        }
    }
    // V번째 완화: 여전히 줄어드는 간선이 있으면 음수 사이클
    for e in edges {
        if dist[e.u] + e.w < dist[e.v] { return true }
    }
    return false
}

let edgesOk  = [(0,1,4),(1,2,-2),(2,3,3)].map { (u:$0.0,v:$0.1,w:$0.2) }
let edgesBad = [(0,1,1),(1,2,-3),(2,0,1)].map { (u:$0.0,v:$0.1,w:$0.2) }
print("\n음수 사이클:")
print(hasNegativeCycle(n: 4, edges: edgesOk))   // false
print(hasNegativeCycle(n: 3, edges: edgesBad))  // true (1→2→0→1: 1-3+1=-1)

// ── 실습 3: 도시 간 최단 경로 (k 이하 경유) ──
// src → dst까지 경유 간선 수가 k 이하인 경로의 최솟값을 구합니다.
// 전략: Bellman-Ford 변형 — 정확히 i개의 간선을 사용한 최솟값을 유지합니다.
//   dp[i][v] = src에서 v까지 정확히 i개의 간선을 사용한 최소 비용
//   경유 도시 수 k → 사용 간선 수 k+1
//   각 단계(i)에서 이전 단계(i-1) 값으로만 갱신 (현재 단계 중간 결과 사용 방지)
func shortestPathAtMostK(n: Int, edges: [[Int]], src: Int, dst: Int, k: Int) -> Int {
    let INF = Int.max / 2
    var prev = Array(repeating: INF, count: n)  // 이전 단계 dist
    prev[src] = 0

    for _ in 0...k {  // 간선을 최대 k+1개 사용 (경유 k개)
        var curr = prev   // 반드시 이전 단계 복사본으로 시작 (같은 단계 내 연쇄 갱신 방지)
        for e in edges {
            let u = e[0], v = e[1], w = e[2]
            if prev[u] < INF {
                curr[v] = min(curr[v], prev[u] + w)
            }
        }
        prev = curr
    }
    return prev[dst] == INF ? -1 : prev[dst]
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
