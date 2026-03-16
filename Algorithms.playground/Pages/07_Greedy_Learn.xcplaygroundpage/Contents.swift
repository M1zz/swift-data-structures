//: [← DP 실습](@previous)
/*:
 # A4 — Greedy

 ## 핵심 아이디어

 매 단계에서 **지역적으로 최선**인 선택을 하면 **전역 최적해**가 됩니다.
 단, 이것이 성립하려면 반드시 증명이 필요합니다.

 ## Greedy 성립 조건

 1. **Greedy Choice Property**: Greedy 선택이 최적해에 포함됨
 2. **최적 부분 구조**: 선택 후 남은 문제도 동일한 구조

 ## 증명 방법: Exchange Argument

 "Greedy가 아닌 최적해가 있다면, Greedy 선택으로 교체해도 결과가 나빠지지 않는다"를 보입니다.

 ## Greedy가 틀리는 케이스

 동전 [1, 5, 6, 9]원으로 11원 거스르기:
 - Greedy: 9 + 1 + 1 = **3개**
 - 최적해: 5 + 6 = **2개** ← Greedy 실패!

 동전이 1, 5, 10, 50, 100 처럼 큰 것이 작은 것의 배수일 때만 Greedy가 성립합니다.

 ## 실무에서는?
 - **Huffman Coding**: 압축 알고리즘 (zip, gzip)
 - **Kruskal MST**: 최소 신장 트리 (네트워크 설계)
 - **스케줄링**: iOS RunLoop의 작업 우선순위 결정
*/
import Foundation

// ── Activity Selection (겹치지 않는 최대 활동 수) ──
func activitySelection(_ intervals: [(start: Int, end: Int)]) -> [(start: Int, end: Int)] {
    let sorted = intervals.sorted { $0.end < $1.end }
    var selected: [(start: Int, end: Int)] = []
    var lastEnd = Int.min

    for act in sorted {
        if act.start >= lastEnd {
            selected.append(act)
            lastEnd = act.end
        }
    }
    return selected
}

let activities = [(1,4),(3,5),(0,6),(5,7),(3,9),(5,9),(6,10),(8,11),(8,12),(2,14),(12,16)]
    .map { (start: $0.0, end: $0.1) }
let result = activitySelection(activities)
print("선택된 활동 수: \(result.count)")  // 4
print("활동: \(result.map { "\($0.start)-\($0.end)" })")

// ── Fractional Knapsack ──
struct Item {
    let weight: Double
    let value: Double
    var unitValue: Double { value / weight }
}

func fractionalKnapsack(capacity: Double, items: [Item]) -> Double {
    let sorted = items.sorted { $0.unitValue > $1.unitValue }
    var remain = capacity, total = 0.0

    for item in sorted {
        if remain <= 0 { break }
        let take = min(remain, item.weight)
        total  += take * item.unitValue
        remain -= take
    }
    return total
}

let items = [Item(weight: 10, value: 60),
             Item(weight: 20, value: 100),
             Item(weight: 30, value: 120)]
print("\nFractional Knapsack (용량 50): \(fractionalKnapsack(capacity: 50, items: items))")  // 240.0

// ── Greedy 실패 반례 ──
func greedyCoinChange(_ coins: [Int], _ amount: Int) -> Int {
    let sorted = coins.sorted(by: >)
    var remain = amount, count = 0
    for coin in sorted {
        count += remain / coin
        remain %= coin
    }
    return remain == 0 ? count : -1
}

print("\nGreedy 동전 [1,5,6,9] → 11원:")
print("Greedy: \(greedyCoinChange([1,5,6,9], 11)) 개")   // 3개 (틀림)
print("DP 최적: 2 개 (5+6)")                              // 2개가 최적

/*:
 [다음 → 실습](@next)
*/
