//: [← Deque](@previous) | [다음 →](@next)
/*: # Ch.05 — Binary Tree 문제 */
import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val; self.left = left; self.right = right
    }
}

// ─────────────────────────────────────────
// 🟢 P1. 이진 트리 최대 깊이 (Maximum Depth of Binary Tree)
// 예: [3,9,20,null,null,15,7] → 3
func maxDepth(_ root: TreeNode?) -> Int {
    // TODO:
    return 0
}
let t1 = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
assert(maxDepth(t1) == 3)
assert(maxDepth(nil) == 0)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 이진 트리 대칭 확인 (Symmetric Tree)
// 예: [1,2,2,3,4,4,3] → true
func isSymmetric(_ root: TreeNode?) -> Bool {
    // TODO:
    return false
}
let symTree = TreeNode(1, TreeNode(2, TreeNode(3), TreeNode(4)), TreeNode(2, TreeNode(4), TreeNode(3)))
assert(isSymmetric(symTree) == true)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 이진 트리 레벨 순서 순회 (Level Order Traversal)
// 각 레벨의 노드 값을 배열의 배열로 반환하세요.
// 예: [3,9,20,null,null,15,7] → [[3],[9,20],[15,7]]
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    // TODO: BFS 활용
    return []
}
assert(levelOrder(t1) == [[3],[9,20],[15,7]])
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 경로 합 존재 여부 (Path Sum)
// 루트에서 리프까지의 경로 중 합이 targetSum인 것이 있으면 true
func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    // TODO:
    return false
}
let psTree = TreeNode(5, TreeNode(4, TreeNode(11, TreeNode(7), TreeNode(2)), nil), TreeNode(8, TreeNode(13), TreeNode(4, nil, TreeNode(1))))
assert(hasPathSum(psTree, 22) == true)
assert(hasPathSum(psTree, 27) == false)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 이진 트리 최대 경로 합 (Binary Tree Maximum Path Sum)
// 경로는 어떤 노드에서 시작해 어떤 노드에서 끝날 수 있습니다.
// 예: [-10,9,20,null,null,15,7] → 42  (15+20+7)
func maxPathSum(_ root: TreeNode?) -> Int {
    // TODO:
    return Int.min
}
let mpTree = TreeNode(-10, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
assert(maxPathSum(mpTree) == 42)
print("P5 통과 ✓")
