//: [← Graph](@previous) | [다음 →](@next)
/*: # Ch.09 — HashTable 문제 */
import Foundation

// ─────────────────────────────────────────
// 🟢 P1. 애너그램 그룹화 (Group Anagrams)
// 문자열 배열에서 애너그램끼리 묶어 반환하세요.
// 예: ["eat","tea","tan","ate","nat","bat"] → [["bat"],["nat","tan"],["ate","eat","tea"]]
func groupAnagrams(_ strs: [String]) -> [[String]] {
    // TODO:
    return []
}
let ga = groupAnagrams(["eat","tea","tan","ate","nat","bat"])
assert(ga.count == 3)
print("P1 통과 ✓")

// ─────────────────────────────────────────
// 🟢 P2. 가장 긴 연속 수열 (Longest Consecutive Sequence)
// 정렬 없이 O(n)으로 가장 긴 연속 수열의 길이를 구하세요.
// 예: [100,4,200,1,3,2] → 4  ([1,2,3,4])
func longestConsecutive(_ nums: [Int]) -> Int {
    // TODO: HashSet 활용
    return 0
}
assert(longestConsecutive([100,4,200,1,3,2]) == 4)
assert(longestConsecutive([0,3,7,2,5,8,4,6,0,1]) == 9)
print("P2 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P3. 부분배열 합 = k (Subarray Sum Equals K)
// 합이 k인 연속 부분배열의 수를 반환하세요.
// 예: [1,1,1], k=2 → 2
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    // TODO: prefix sum + HashMap
    return 0
}
assert(subarraySum([1,1,1], 2) == 2)
assert(subarraySum([1,2,3], 3) == 2)
print("P3 통과 ✓")

// ─────────────────────────────────────────
// 🟡 P4. 가장 긴 중복 없는 부분 문자열 (Longest Substring Without Repeating Characters)
// 예: "abcabcbb" → 3 ("abc")
func lengthOfLongestSubstring(_ s: String) -> Int {
    // TODO: 슬라이딩 윈도우 + HashMap
    return 0
}
assert(lengthOfLongestSubstring("abcabcbb") == 3)
assert(lengthOfLongestSubstring("bbbbb") == 1)
assert(lengthOfLongestSubstring("pwwkew") == 3)
print("P4 통과 ✓")

// ─────────────────────────────────────────
// 🔴 P5. 최소 윈도우 부분문자열 (Minimum Window Substring)
// s에서 t의 모든 문자를 포함하는 최소 윈도우를 반환하세요.
// 예: s="ADOBECODEBANC", t="ABC" → "BANC"
func minWindow(_ s: String, _ t: String) -> String {
    // TODO: 슬라이딩 윈도우 + 두 카운터 맵
    return ""
}
assert(minWindow("ADOBECODEBANC", "ABC") == "BANC")
assert(minWindow("a", "a") == "a")
print("P5 통과 ✓")
