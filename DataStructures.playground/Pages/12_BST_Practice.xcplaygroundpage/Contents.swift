//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.06 실습 — Binary Search Tree

 BST를 직접 구현하고, 삭제 연산까지 도전해보세요.
*/
import Foundation

// ── 헬퍼 ──
func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── BST Node ──
final class BSTNode<T: Comparable> {
    var val: T
    var left: BSTNode<T>?
    var right: BSTNode<T>?
    init(_ val: T) { self.val = val }
}

// ── 실습 1: BST 구현 ──
struct BST<T: Comparable> {
    private(set) var root: BSTNode<T>?

    // TODO: insert — BST 조건 유지하며 삽입
    mutating func insert(_ v: T) { root = _insert(root, v) }
    private func _insert(_ n: BSTNode<T>?, _ v: T) -> BSTNode<T> {
        guard let n = n else { return BSTNode(v) }
        if v < n.val { n.left = _insert(n.left, v) }
        else if v > n.val { n.right = _insert(n.right, v) }
        return n
    }

    // TODO: contains — 값 존재 여부 확인
    func contains(_ v: T) -> Bool {
        var cur = root
        while let n = cur {
            if v == n.val { return true }
            cur = v < n.val ? n.left : n.right
        }
        return false
    }

    // TODO: inorder — 정렬된 결과 반환
    func inorder() -> [T] { _inorder(root) }
    private func _inorder(_ n: BSTNode<T>?) -> [T] {
        guard let n = n else { return [] }
        return _inorder(n.left) + [n.val] + _inorder(n.right)
    }

    // TODO: delete — 3가지 케이스 처리
    mutating func remove(_ v: T) { root = _remove(root, v) }
    private func _remove(_ n: BSTNode<T>?, _ v: T) -> BSTNode<T>? {
        guard let n = n else { return nil }
        if v < n.val { n.left = _remove(n.left, v) }
        else if v > n.val { n.right = _remove(n.right, v) }
        else {
            // Case 1 & 2: 자식이 0개 또는 1개
            if n.left == nil { return n.right }
            if n.right == nil { return n.left }
            // Case 3: 자식이 2개 → 후계자(오른쪽 최솟값)로 대체
            let succ = _minNode(n.right!)
            n.val = succ.val
            n.right = _remove(n.right, succ.val)
        }
        return n
    }

    private func _minNode(_ n: BSTNode<T>) -> BSTNode<T> {
        var cur = n
        while let l = cur.left { cur = l }
        return cur
    }

    var height: Int { _height(root) }
    private func _height(_ n: BSTNode<T>?) -> Int {
        guard let n = n else { return 0 }
        return 1 + max(_height(n.left), _height(n.right))
    }
}

// ── 테스트 ──
divider("BST 기본 연산")
var bst = BST<Int>()
[40, 20, 60, 10, 30, 50, 70].forEach { bst.insert($0) }
print("중위 순회:", bst.inorder())
print("높이:", bst.height)
print("contains(30):", bst.contains(30))
print("contains(99):", bst.contains(99))

divider("삭제 연산")
bst.remove(20)
print("remove(20):", bst.inorder())

bst.remove(40)  // 루트 삭제
print("remove(40):", bst.inorder())

divider("편향 vs 균형")
var skewed = BST<Int>()
(1...7).forEach { skewed.insert($0) }
print("정렬 입력 높이:", skewed.height)

var balanced = BST<Int>()
[4, 2, 6, 1, 3, 5, 7].forEach { balanced.insert($0) }
print("균형 입력 높이:", balanced.height)

/*:
 ## 도전 과제
 1. BST에서 **최솟값/최댓값**을 O(log n)으로 찾는 함수를 구현해보세요
 2. **범위 검색**: `range(low:high:)` — low~high 사이의 모든 값을 반환
 3. BST를 사용해 **중복 없는 정렬 집합(SortedSet)**을 구현해보세요
*/
