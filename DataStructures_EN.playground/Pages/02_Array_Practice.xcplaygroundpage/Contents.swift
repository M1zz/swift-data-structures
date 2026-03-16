//: [← Back to Concepts](@previous)
/*:
 # Ch.01 Practice — Array vs ContiguousArray

 Fill in the TODOs below to implement each exercise.
*/
import Foundation

// ── Helper ──
func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

// ── Exercise 1: CoW Verification ──
// TODO: Create array a, copy it to b, then modify b to trigger CoW
var a = [10, 20, 30]
// Write your code here



// ── Exercise 2: Array vs ContiguousArray Performance Comparison ──
let n = 100_000

// TODO: Measure time to append 0..<n to Array<Int>
measureTime("Array append") {
    var arr = [Int]()
    for i in 0..<n { arr.append(i) }
}

// TODO: Measure time to append 0..<n to ContiguousArray<Int>
measureTime("ContiguousArray append") {
    var arr = ContiguousArray<Int>()
    for i in 0..<n { arr.append(i) }
}

// ── Exercise 3: ArraySlice Memory Sharing ──
// TODO: create a slice of the array and verify it shares memory with the original
let original = Array(0..<10)
let slice = original[2..<5]
print("slice: \(Array(slice))")
print("slice.startIndex: \(slice.startIndex)")  // 2부터 시작!

/*:
 ## Challenges
 1. Measure how much performance improves with `reserveCapacity()`
 2. Compare `contains()` vs `Set.contains()` performance (Ch.09 Hash Table preview!)
*/
