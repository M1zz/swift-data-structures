//: [← HashTable](@previous) | [다음 →](@next)
/*: # Ch.10 — Trie 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. Trie 구현 (Implement Trie)
// insert, search, startsWith 세 연산을 구현하세요.
final class Trie {
    // TODO:
    func insert(_ word: String) { /* TODO */ }
    func search(_ word: String) -> Bool { /* TODO */ return false }
    func startsWith(_ prefix: String) -> Bool { /* TODO */ return false }
}
let trie = Trie()
trie.insert("apple")
assert(trie.search("apple") == true)
assert(trie.search("app") == false)
assert(trie.startsWith("app") == true)
trie.insert("app")
assert(trie.search("app") == true)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P2. 단어 수 세기 (Count Words With Prefix)
// Trie에 단어를 삽입 후, 특정 접두어로 시작하는 단어의 수를 반환하세요.
// 힌트: 각 노드에 count 프로퍼티 추가
final class TrieWithCount {
    // TODO:
    func insert(_ word: String) { /* TODO */ }
    func countPrefix(_ prefix: String) -> Int { /* TODO */ return 0 }
}
let tc = TrieWithCount()
["apple","app","application","apply","banana"].forEach { tc.insert($0) }
assert(tc.countPrefix("app") == 4)
assert(tc.countPrefix("ban") == 1)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 와일드카드 검색 (Search with Wildcard '.')
// '.'은 임의의 한 문자와 매칭됩니다.
// 예: insert("bad"), insert("dad"), search(".ad") → true
final class WildcardTrie {
    // TODO:
    func insert(_ word: String) { /* TODO */ }
    func search(_ word: String) -> Bool { /* TODO */ return false }  // DFS로 '.' 처리
}
let wt = WildcardTrie()
["bad","dad","mad"].forEach { wt.insert($0) }
assert(wt.search(".ad") == true)
assert(wt.search("b..") == true)
assert(wt.search("pad") == false)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P4. 배열 내 두 단어의 최대 XOR (Maximum XOR of Two Numbers)
// Binary Trie를 사용하여 배열에서 두 원소의 XOR 최댓값을 O(32n)으로 구하세요.
// 예: [3,10,5,25,2,8] → 28  (5 XOR 25)
func findMaximumXOR(_ nums: [Int]) -> Int {
    // TODO: 비트 Trie (0/1 트리)
    return 0
}
assert(findMaximumXOR([3,10,5,25,2,8]) == 28)
print("P4 통과 ✓")
