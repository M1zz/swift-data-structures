//: # Ch.05 — Binary Tree
//: 전위/중위/후위/레벨 순회를 재귀와 반복 두 방법으로 구현합니다.
import Foundation

indirect enum BTree<T> {
    case empty
    case node(T, BTree<T>, BTree<T>)
}

extension BTree {
    init(_ v: T, _ l: BTree<T> = .empty, _ r: BTree<T> = .empty) {
        self = .node(v, l, r)
    }
}

// 예시 트리:    1
//             / \
//            2   3
//           / \   \
//          4   5   6
let tree = BTree(1,
    BTree(2, BTree(4), BTree(5)),
    BTree(3, .empty, BTree(6)))

//: ## 재귀 순회
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

print("전위 (Root→L→R):", preorder(tree))   // [1,2,4,5,3,6]
print("중위 (L→Root→R):", inorder(tree))    // [4,2,5,1,3,6]
print("후위 (L→R→Root):", postorder(tree))  // [4,5,2,6,3,1]

//: ## BFS (레벨 순서) — 반복 + Queue
func levelorder<T>(_ t: BTree<T>) -> [[T]] {
    guard case .node = t else { return [] }
    var result: [[T]] = []
    var queue: [BTree<T>] = [t]
    while !queue.isEmpty {
        var level: [T] = []
        let levelSize = queue.count
        for _ in 0..<levelSize {
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
print("레벨 순서:", levelorder(tree))  // [[1],[2,3],[4,5,6]]

//: ## 트리 높이
func height<T>(_ t: BTree<T>) -> Int {
    guard case .node(_, let l, let r) = t else { return 0 }
    return 1 + max(height(l), height(r))
}
print("높이:", height(tree))  // 3

//: 실습: 두 트리가 동일한지 비교하는 isEqual 함수를 작성해보세요.
