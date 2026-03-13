//: # Ch.06 — Binary Search Tree
//: 삽입/탐색/삭제를 직접 구현합니다. 불변 조건: left < root < right.
import Foundation

final class BSTNode<T: Comparable> {
    var val: T; var left: BSTNode<T>?; var right: BSTNode<T>?
    init(_ val: T) { self.val = val }
}

struct BST<T: Comparable> {
    private(set) var root: BSTNode<T>?

    mutating func insert(_ v: T) { root = _insert(root, v) }
    private func _insert(_ n: BSTNode<T>?, _ v: T) -> BSTNode<T> {
        guard let n = n else { return BSTNode(v) }
        if v < n.val { n.left = _insert(n.left, v) }
        else if v > n.val { n.right = _insert(n.right, v) }
        return n
    }

    func contains(_ v: T) -> Bool {
        var cur = root
        while let n = cur {
            if v == n.val { return true }
            cur = v < n.val ? n.left : n.right
        }
        return false
    }

    // 삭제: 3가지 케이스
    mutating func remove(_ v: T) { root = _remove(root, v) }
    private func _remove(_ n: BSTNode<T>?, _ v: T) -> BSTNode<T>? {
        guard let n = n else { return nil }
        if v < n.val { n.left = _remove(n.left, v) }
        else if v > n.val { n.right = _remove(n.right, v) }
        else {
            if n.left == nil { return n.right }   // Case 1 & 2
            if n.right == nil { return n.left }   // Case 2
            let succ = _minNode(n.right!)          // Case 3: 후계자
            n.val = succ.val
            n.right = _remove(n.right, succ.val)
        }
        return n
    }
    private func _minNode(_ n: BSTNode<T>) -> BSTNode<T> {
        var cur = n; while let l = cur.left { cur = l }; return cur
    }

    func inorder() -> [T] { _inorder(root) }
    private func _inorder(_ n: BSTNode<T>?) -> [T] {
        guard let n = n else { return [] }
        return _inorder(n.left) + [n.val] + _inorder(n.right)
    }

    var height: Int { _height(root) }
    private func _height(_ n: BSTNode<T>?) -> Int {
        guard let n = n else { return 0 }
        return 1 + max(_height(n.left), _height(n.right))
    }
}

print("=== BST 실습 ===")
var bst = BST<Int>()
[40, 20, 60, 10, 30, 50, 70].forEach { bst.insert($0) }
print("삽입 후 중위:", bst.inorder())  // 정렬된 순서: [10,20,30,40,50,60,70]
print("높이:", bst.height)

print("contains(30):", bst.contains(30))  // true
print("contains(99):", bst.contains(99))  // false

bst.remove(20)
print("remove(20) 후 중위:", bst.inorder())  // [10,30,40,50,60,70]

bst.remove(40)  // 루트 삭제 — 후계자(50)로 대체
print("remove(40) 후 중위:", bst.inorder())  // [10,30,50,60,70]

// 정렬된 배열을 넣으면 최악의 편향 트리 발생
print("\n=== 편향 트리 위험 ===")
var skewed = BST<Int>()
[1,2,3,4,5,6,7].forEach { skewed.insert($0) }
print("정렬 입력 높이:", skewed.height)  // 7 (최악)

var balanced = BST<Int>()
[4,2,6,1,3,5,7].forEach { balanced.insert($0) }
print("균형 입력 높이:", balanced.height)  // 3 (최적)
//: > 실제로는 AVL/Red-Black Tree로 자동 균형을 유지합니다.
//: 실습: BST를 사용해 중복 없는 정렬된 집합(SortedSet)을 구현해보세요.
