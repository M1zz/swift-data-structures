/*:
 # Ch.06 — Binary Search Tree (BST)

 ## 핵심 개념: BST 불변 조건

 BST는 모든 노드에서 다음 조건을 만족하는 이진 트리입니다:

 > **왼쪽 서브트리의 모든 값 < 현재 노드 < 오른쪽 서브트리의 모든 값**

 이 조건 덕분에 탐색, 삽입, 삭제가 **O(log n)**에 가능합니다.
 단, 정렬된 데이터를 순서대로 넣으면 **편향 트리**가 되어 O(n)으로 퇴화합니다.

 ```
 균형 BST:       편향 BST:
      40           1
     /  \           \
   20    60          2
   / \   / \          \
 10  30 50  70         3
                        \
                         4    ← O(n) 탐색!
 ```

 ## 시간복잡도

 | 연산 | 평균 | 최악 (편향) | 비고 |
 |------|------|------------|------|
 | search | O(log n) | O(n) | 이진 탐색 |
 | insert | O(log n) | O(n) | 리프까지 이동 |
 | delete | O(log n) | O(n) | 3가지 케이스 |
 | inorder | O(n) | O(n) | 정렬 결과 |

 ## 실무에서는?
 - **가격 범위 필터**: "1만원~5만원 상품 검색" → BST 범위 탐색
 - **정렬된 데이터 유지**: 삽입 시 자동 정렬 (inorder = sorted)
 - **Swift 표준 라이브러리**: 내부적으로 Red-Black Tree 사용 (SortedSet 등)
 - **데이터베이스 인덱스**: B-Tree는 BST의 확장
*/
import Foundation

// ── BST 구현 ──
final class BSTNode<T: Comparable> {
    var val: T
    var left: BSTNode<T>?
    var right: BSTNode<T>?
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

// ── 데모 ──
print("=== BST 삽입 & 중위 순회 ===")
var bst = BST<Int>()
[40, 20, 60, 10, 30, 50, 70].forEach { bst.insert($0) }
print("삽입 후 중위 순회:", bst.inorder())  // 정렬: [10, 20, 30, 40, 50, 60, 70]
print("높이:", bst.height)  // 3

print("\ncontains(30):", bst.contains(30))  // true
print("contains(99):", bst.contains(99))    // false

// ── 편향 트리 위험 시연 ──
print("\n=== 편향 트리 vs 균형 트리 ===")
var skewed = BST<Int>()
[1, 2, 3, 4, 5, 6, 7].forEach { skewed.insert($0) }
print("정렬된 입력 → 높이:", skewed.height)  // 7 (최악)

var balanced = BST<Int>()
[4, 2, 6, 1, 3, 5, 7].forEach { balanced.insert($0) }
print("균형 입력 → 높이:", balanced.height)    // 3 (최적)
/*:
 > 실제 프로덕션에서는 **AVL Tree** 또는 **Red-Black Tree**를 사용해
 > 삽입/삭제 시 자동으로 균형을 유지합니다.

 [다음 → 실습](@next)
*/
