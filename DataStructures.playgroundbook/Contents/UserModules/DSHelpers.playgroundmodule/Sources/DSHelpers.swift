import Foundation

/// 성능 측정 헬퍼
public func measureTime(_ label: String, _ block: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    block()
    let elapsed = CFAbsoluteTimeGetCurrent() - start
    print("⏱ \(label): \(String(format: "%.4f", elapsed))초")
}

/// 구분선 출력
public func divider(_ title: String = "") {
    if title.isEmpty { print("\n" + String(repeating: "─", count: 40)) }
    else { print("\n── \(title) " + String(repeating: "─", count: max(0, 36 - title.count))) }
}
