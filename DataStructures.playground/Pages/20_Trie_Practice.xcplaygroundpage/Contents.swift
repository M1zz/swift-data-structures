//: [← 개념으로 돌아가기](@previous)
/*:
 # Ch.10 실습 — Trie

 Trie를 직접 구현하고, 자동완성과 삭제까지 구현해보세요.
*/
import Foundation

// ── 헬퍼 ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}

// ── Trie Node ──
final class TrieNode {
    var children: [Character: TrieNode] = [:]
    var isEndOfWord = false
}

// ── 실습 1: Trie 구현 ──
final class Trie {
    let root = TrieNode()

    // TODO: insert — 단어 삽입
    func insert(_ word: String) {
        var cur = root
        for ch in word {
            if cur.children[ch] == nil { cur.children[ch] = TrieNode() }
            cur = cur.children[ch]!
        }
        cur.isEndOfWord = true
    }

    // TODO: search — 정확히 일치하는 단어 검색
    func search(_ word: String) -> Bool {
        var cur = root
        for ch in word {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return cur.isEndOfWord
    }

    // TODO: startsWith — 접두어 존재 확인
    func startsWith(_ prefix: String) -> Bool {
        var cur = root
        for ch in prefix {
            guard let next = cur.children[ch] else { return false }
            cur = next
        }
        return true
    }

    // TODO: autocomplete — 접두어로 시작하는 모든 단어 반환
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

    // TODO: delete — 단어 삭제 (불필요한 노드 정리)
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

// ── 테스트 ──
divider("Trie 기본 연산")
let trie = Trie()
let words = ["app", "apple", "apply", "application", "apt",
             "swift", "swiftui", "swifty", "banana", "band"]
words.forEach { trie.insert($0) }

print("search('apple'):", trie.search("apple"))
print("search('appl'):", trie.search("appl"))
print("startsWith('app'):", trie.startsWith("app"))

divider("자동완성")
print("autocomplete('app'):", trie.autocomplete("app"))
print("autocomplete('sw'):", trie.autocomplete("sw"))
print("autocomplete('ban'):", trie.autocomplete("ban"))

divider("삭제")
trie.delete("apply")
print("delete('apply') 후:")
print("  autocomplete('app'):", trie.autocomplete("app"))
print("  search('apply'):", trie.search("apply"))
print("  search('apple'):", trie.search("apple"))  // 여전히 true

// ── 실습 2: 성능 비교 ──
divider("성능 비교")

let bigTrie = Trie()
let sampleWords = (0..<10_000).map { "word\($0)" }
sampleWords.forEach { bigTrie.insert($0) }

measureTime("Trie autocomplete('word1')") {
    _ = bigTrie.autocomplete("word1", limit: 20)
}

measureTime("Array filter('word1')") {
    _ = sampleWords.filter { $0.hasPrefix("word1") }
}

/*:
 ## 도전 과제
 1. **단어 수 세기**: 특정 접두어로 시작하는 단어가 몇 개인지 O(m)에 구하는 `countPrefix()` 구현
 2. **와일드카드 검색**: `search("ap.le")` — `.`은 아무 문자와 매칭
 3. **사전순 정렬**: Trie에 저장된 모든 단어를 사전순으로 출력

 ---
 ## 🎉 자료구조 10개 완료!
 다음 단계: **Algorithms.playground** 를 열어 정렬, 이진 탐색, DP, Greedy, Backtracking, 최단 경로를 학습하세요.
*/
