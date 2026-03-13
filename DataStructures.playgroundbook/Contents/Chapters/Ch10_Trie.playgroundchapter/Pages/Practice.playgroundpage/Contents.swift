//: # Ch.10 — Trie
//: 자동완성 기능 구현에 활용하는 접두어 트리.
import Foundation

final class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord = false
    var wordCount = 0  // 이 노드를 지나는 단어 수
}

final class Trie {
    let root = TrieNode()

    // O(m) — m: 단어 길이
    func insert(_ word: String) {
        var cur = root
        for ch in word {
            if cur.children[ch] == nil { cur.children[ch] = TrieNode() }
            cur = cur.children[ch]!
            cur.wordCount += 1
        }
        cur.isEndOfWord = true
    }

    // O(m)
    func search(_ word: String) -> Bool {
        var cur = root
        for ch in word {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return cur.isEndOfWord
    }

    // O(m)
    func startsWith(_ prefix: String) -> Bool {
        var cur = root
        for ch in prefix {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return true
    }

    // O(m + k) — k: 결과 단어 수
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

    // 단어 삭제 O(m)
    @discardableResult
    func delete(_ word: String) -> Bool {
        func _del(_ node: TrieNode, _ chars: [Character], _ idx: Int) -> Bool {
            if idx == chars.count {
                guard node.isEndOfWord else { return false }
                node.isEndOfWord = false
                return node.children.isEmpty
            }
            let ch = chars[idx]
            guard let child = node.children[ch] else { return false }
            let shouldDelete = _del(child, chars, idx + 1)
            if shouldDelete { node.children.removeValue(forKey: ch) }
            return shouldDelete && !node.isEndOfWord && node.children.isEmpty
        }
        return _del(root, Array(word), 0)
    }
}

print("=== Trie 실습 ===")
let trie = Trie()
let words = ["app", "apple", "apply", "application", "apt",
             "swift", "swiftui", "swifty", "banana", "band"]
words.forEach { trie.insert($0) }

print("search('apple'):", trie.search("apple"))     // true
print("search('appl'):", trie.search("appl"))       // false
print("startsWith('app'):", trie.startsWith("app")) // true

print("\nautocomplete('app'):", trie.autocomplete("app"))
print("autocomplete('swift'):", trie.autocomplete("swift"))

trie.delete("apply")
print("\ndelete('apply') 후 autocomplete('app'):", trie.autocomplete("app"))

// Array.filter와 성능 비교 개념
print("\n=== 성능 비교 개념 ===")
let allWords = words
let prefix = "swift"
// Array filter: O(n × m)
let filtered = allWords.filter { $0.hasPrefix(prefix) }
print("Array.filter('\(prefix)'):", filtered)
// Trie: O(m + k)
let trieResult = trie.autocomplete(prefix)
print("Trie.autocomplete('\(prefix)'):", trieResult)
print("단어 수가 100만이면 Trie가 압도적으로 빠릅니다.")
//: 실습: UISearchBar + Trie를 연결해 실시간 자동완성 앱을 만들어보세요.
