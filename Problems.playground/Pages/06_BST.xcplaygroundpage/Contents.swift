//: [← BinaryTree](@previous) | [다음 →](@next)
/*: # Ch.06 — BST 문제 */
import Foundation

class TreeNode {
    var val: Int; var left: TreeNode?; var right: TreeNode?
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) { self.val = val; self.left = left; self.right = right }
}

// ─────────────────────────────────────────
// 🟢 P1. BST 유효성 검사 (Validate BST)
// 주어진 트리가 유효한 BST인지 확인하세요.
func isValidBST(_ root: TreeNode?) -> Bool {
    // TODO: 범위(min, max) 전달 방식 권장
    return false
}
let validBST = TreeNode(2, TreeNode(1), TreeNode(3))
let invalidBST = TreeNode(5, TreeNode(1), TreeNode(4, TreeNode(3), TreeNode(6)))
assert(isValidBST(validBST) == true)
assert(isValidBST(invalidBST) == false)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. BST에서 k번째 최솟값 (Kth Smallest in BST)
// 중위 순회(in-order)를 이용하세요.
func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    // TODO:
    return -1
}
let bst = TreeNode(3, TreeNode(1, nil, TreeNode(2)), TreeNode(4))
assert(kthSmallest(bst, 1) == 1)
assert(kthSmallest(bst, 3) == 3)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. BST에서 두 노드의 합 = k (Two Sum in BST)
// BST에서 합이 k가 되는 두 노드가 존재하면 true
// 힌트: in-order 순회로 정렬 배열을 만들거나, HashSet 사용
func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
    // TODO:
    return false
}
assert(findTarget(TreeNode(5, TreeNode(3, TreeNode(2), TreeNode(4)), TreeNode(6, nil, TreeNode(7))), 9) == true)
assert(findTarget(TreeNode(5, TreeNode(3, TreeNode(2), TreeNode(4)), TreeNode(6, nil, TreeNode(7))), 28) == false)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 정렬 배열로 균형 BST 만들기 (Convert Sorted Array to BST)
// 예: [-10,-3,0,5,9] → 균형 BST
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    // TODO: 중간값을 루트로 재귀 분할
    return nil
}
let balancedBST = sortedArrayToBST([-10,-3,0,5,9])
assert(maxDepth(balancedBST) <= 3)
print("P4 통과 ✓")
func maxDepth(_ root: TreeNode?) -> Int { root == nil ? 0 : 1 + max(maxDepth(root?.left), maxDepth(root?.right)) }

// ─────────────────────────────────────────
// 🔴 P5. BST를 Greater Sum Tree로 변환
// 각 노드의 값을 자신보다 크거나 같은 모든 노드의 합으로 교체하세요.
// 예: [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
// 힌트: 역 중위 순회 (right → root → left)
func convertBST(_ root: TreeNode?) -> TreeNode? {
    // TODO:
    return nil
}
let gstInput = TreeNode(4, TreeNode(1, TreeNode(0), TreeNode(2, nil, TreeNode(3))), TreeNode(6, TreeNode(5), TreeNode(7, nil, TreeNode(8))))
let gst = convertBST(gstInput)
// 루트(4)의 새 값 = 4+5+6+7+8 = 30
assert(gst?.val == 30)
print("P5 통과 ✓")
