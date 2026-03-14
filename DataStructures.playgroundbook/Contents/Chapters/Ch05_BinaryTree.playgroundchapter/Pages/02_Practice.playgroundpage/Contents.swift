//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.05 실습 — Binary Tree

 indirect enum을 사용해 Binary Tree와 순회를 직접 구현해보세요.
*/
import Foundation

// ── 헬퍼 ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── 실습 1: BTree 정의 ──
indirect enum BTree<T> {
    case empty
    case node(T, BTree<T>, BTree<T>)
}

extension BTree {
    init(_ v: T, _ l: BTree<T> = .empty, _ r: BTree<T> = .empty) {
        self = .node(v, l, r)
    }
}

// ── 실습 2: 순회 구현 ──

// TODO: 전위 순회
func preorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return [v] + preorder(l) + preorder(r)
}

// TODO: 중위 순회
func inorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return inorder(l) + [v] + inorder(r)
}

// TODO: 후위 순회
func postorder<T>(_ t: BTree<T>) -> [T] {
    guard case .node(let v, let l, let r) = t else { return [] }
    return postorder(l) + postorder(r) + [v]
}

// TODO: 레벨 순회
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

// ── 테스트 ──
//        1
//       / \
//      2   3
//     / \   \
//    4   5   6
let tree = BTree(1,
    BTree(2, BTree(4), BTree(5)),
    BTree(3, .empty, BTree(6)))

divider("순회 테스트")
print("전위:", preorder(tree))
print("중위:", inorder(tree))
print("후위:", postorder(tree))
print("레벨:", levelorder(tree))

// ── 실습 3: 트리 높이 계산 ──
divider("높이 계산")

// TODO: 트리 높이를 재귀적으로 계산
func height<T>(_ t: BTree<T>) -> Int {
    guard case .node(_, let l, let r) = t else { return 0 }
    return 1 + max(height(l), height(r))
}

print("높이:", height(tree))  // 3

// ── 실습 4: 노드 수 세기 ──
func nodeCount<T>(_ t: BTree<T>) -> Int {
    guard case .node(_, let l, let r) = t else { return 0 }
    return 1 + nodeCount(l) + nodeCount(r)
}
print("노드 수:", nodeCount(tree))  // 6

/*:
 ## 도전 과제
 1. 두 트리가 **구조적으로 동일한지** 비교하는 `isEqual` 함수를 구현해보세요
 2. 트리를 **거울 반전(mirror)**하는 함수를 구현해보세요
 3. 특정 값까지의 **경로(path)**를 찾는 함수를 구현해보세요
*/
