//: > **Tip**: Enable **Editor → Show Rendered Markup** in Xcode to render the markup.
/*:
 # Ch.10 — Trie (Prefix Tree)

 ## 핵심 개념: 접두어 트리

 Trie는 **문자열의 접두어(prefix)**를 공유하는 트리 구조입니다.
 각 노드는 하나의 **문자(Character)**를 나타내고,
 루트에서 특정 노드까지의 경로가 하나의 **접두어**가 됩니다.

 ```
 root
 ├─ a
 │  ├─ p
 │  │  ├─ p ✓ ("app")
 │  │  │  ├─ l
 │  │  │  │  ├─ e ✓ ("apple")
 │  │  │  │  └─ y ✓ ("apply")
 │  │  └─ t ✓ ("apt")
 └─ s
    └─ w
       └─ i
          └─ f
             └─ t ✓ ("swift")
 ```

 ## 핵심 특성

 검색 시간이 **저장된 단어 수(n)와 무관**합니다!
 오직 **검색어의 길이(m)**에만 의존합니다.

 **Array.filter vs Trie 비교**
 - **접두어 검색**: Array.filter O(n × m) / Trie **O(m + k)**
 - **100만 단어, "sw" 검색**: Array.filter 100만 번 비교 / Trie 2글자만 탐색

 ## Time Complexity

 **Time Complexity**
 - **insert**: O(m) — m = 단어 길이
 - **search**: O(m) — 정확히 일치
 - **startsWith**: O(m) — 접두어 존재 확인
 - **autocomplete**: O(m + k) — k = 결과 단어 수
 - **delete**: O(m) — 불필요한 노드 정리

 ## In Practice?
 - **자동완성**: 검색엔진, IDE 코드 자동완성
 - **맞춤법 검사**: 단어 존재 여부 빠른 확인
 - **IP 라우팅**: 가장 긴 접두어 매칭 (Longest Prefix Match)
 - **T9 키패드 입력**: 전화번호부 검색
*/
import Foundation

// ── Trie 구현 ──
final class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord = false
}

final class Trie {
    let root = TrieNode()

    func insert(_ word: String) {
        var cur = root
        for ch in word {
            if cur.children[ch] == nil { cur.children[ch] = TrieNode() }
            cur = cur.children[ch]!
        }
        cur.isEndOfWord = true
    }

    func search(_ word: String) -> Bool {
        var cur = root
        for ch in word {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return cur.isEndOfWord
    }

    func startsWith(_ prefix: String) -> Bool {
        var cur = root
        for ch in prefix {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return true
    }

    func autocomplete(_ prefix: String, limit: Int = 10) -> [String] {
        var cur = root
        for ch in prefix {
            guard let next = cur.children[ch] else { return [] }
            cur = next
        }
        var results: [String] = []
        func dfs(_ node: TrieNode, _ path: String) {
            if results.count >= limit { return }
            if node.isEndOfWord { results.append(path) }
            for (ch, child) in node.children.sorted(by: { $0.key < $1.key }) {
                dfs(child, path + String(ch))
            }
        }
        dfs(cur, prefix)
        return results
    }
}

// ── 데모 ──
print("=== Trie 자동완성 ===")
let trie = Trie()
let words = ["app", "apple", "apply", "application", "apt",
             "swift", "swiftui", "swifty", "banana", "band"]
words.forEach { trie.insert($0) }

print("search('apple'):", trie.search("apple"))       // true
print("search('appl'):", trie.search("appl"))          // false
print("startsWith('app'):", trie.startsWith("app"))    // true
print("startsWith('xyz'):", trie.startsWith("xyz"))    // false

print("\nautocomplete('app'):", trie.autocomplete("app"))
print("autocomplete('sw'):", trie.autocomplete("sw"))
print("autocomplete('ban'):", trie.autocomplete("ban"))

// ── 성능 비교 개념 ──
print("\n=== Array.filter vs Trie ===")
let prefix = "swift"
let filtered = words.filter { $0.hasPrefix(prefix) }
let trieResult = trie.autocomplete(prefix)
print("Array.filter('\(prefix)'):", filtered)
print("Trie.autocomplete('\(prefix)'):", trieResult)
print("→ 단어가 100만 개이면 Trie가 압도적으로 빠릅니다!")
/*:
 > Trie의 단점은 **메모리 사용량**입니다.
 > 각 노드가 Dictionary를 가지므로 오버헤드가 큽니다.
 > In practice는 **Ternary Search Tree**나 **DAWG**로 메모리를 최적화합니다.

 [Next → Practice](@next)
*/
