//: > **Tip**: Xcode 메뉴에서 **Editor → Show Rendered Markup** 을 켜면 마크업이 렌더링되어 더 읽기 쉽습니다.
/*:
 # Ch.05 — Binary Tree

 ## 핵심 개념: 재귀적 트리 구조

 Binary Tree는 각 노드가 **최대 2개의 자식**을 가지는 트리입니다.
 Swift에서는 `indirect enum`으로 우아하게 표현할 수 있습니다:

 ```swift
 indirect enum BTree<T> {
     case empty
     case node(T, BTree<T>, BTree<T>)
 }
 ```

 ## 4가지 순회 방법

 **순회 방법**
 - **전위 (Preorder)**: Root → L → R — 트리 복사, 직렬화
 - **중위 (Inorder)**: L → Root → R — BST 정렬 출력
 - **후위 (Postorder)**: L → R → Root — 메모리 해제, 수식 계산
 - **레벨 (Level-order)**: 층별 좌→우 — BFS, 레벨별 처리

 ## 시간복잡도

 **시간복잡도**
 - **순회 (전위/중위/후위)**: O(n) — 모든 노드 방문
 - **레벨 순회**: O(n) — Queue 사용
 - **높이 계산**: O(n) — 재귀
 - **노드 수 세기**: O(n) — 재귀

 ## 실무에서는?
 - **SwiftUI View 계층**: `VStack { Text(); HStack { ... } }` 가 트리 구조
 - **DOM 트리**: HTML 파싱 결과
 - **파일 시스템**: 디렉터리/파일 구조
 - **수식 파서**: `(1 + 2) * 3` → 트리로 변환 후 후위 순회로 계산
*/
import Foundation

// ── indirect enum으로 트리 정의 ──
indirect enum BTree<T> {
    case empty
    case node(T, BTree<T>, BTree<T>)
}

extension BTree {
    init(_ v: T, _ l: BTree<T> = .empty, _ r: BTree<T> = .empty) {
        self = .node(v, l, r)
    }
}

// ── 예시 트리 구축 ──
//        1
//       / \
//      2   3
//     / \   \
//    4   5   6
let tree = BTree(1,
    BTree(2, BTree(4), BTree(5)),
    BTree(3, .empty, BTree(6)))

// ── 4가지 순회 ──
func preorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return [v] + preorder(l) + preorder(r)
}

func inorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return inorder(l) + [v] + inorder(r)
}

func postorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return postorder(l) + postorder(r) + [v]
}

func levelorder<T>(_ t: BTree<T>) -> [[T]] {
    guard case .node = t else { return [] }
    var result: [[T]] = []
    var queue: [BTree<T>] = [t]
    while !queue.isEmpty {
        var level: [T] = []
        let size = queue.count
        for _ in 0..<size {
            let node = queue.removeFirst()
            if case .node(let v, let l, let r) = node {
                level.append(v)
                if case .node = l { queue.append(l) }
                if case .node = r { queue.append(r) }
            }
        }
        result.append(level)
    }
    return result
}

print("=== 4가지 순회 ===")
print("전위 (Root→L→R):", preorder(tree))    // [1, 2, 4, 5, 3, 6]
print("중위 (L→Root→R):", inorder(tree))     // [4, 2, 5, 1, 3, 6]
print("후위 (L→R→Root):", postorder(tree))   // [4, 5, 2, 6, 3, 1]
print("레벨 순서:", levelorder(tree))          // [[1], [2, 3], [4, 5, 6]]

// ── 트리 높이 ──
func height<T>(_ t: BTree<T>) -> Int {
    guard case .node(_, let l, let r) = t else { return 0 }
    return 1 + max(height(l), height(r))
}
print("\n트리 높이:", height(tree))  // 3
/*:
 > `indirect` 키워드가 없으면 enum이 자기 자신을 포함할 수 없습니다.
 > `indirect`는 값을 힙에 저장해서 재귀적 구조를 가능하게 합니다.

 [다음 → 실습](@next)
*/
