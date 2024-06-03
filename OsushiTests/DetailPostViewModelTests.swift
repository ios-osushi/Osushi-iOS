import XCTest
@testable import Osushi

final class DetailPostViewModelTests: XCTestCase {
    let viewModel = DetailPostViewModel()
    let markdownContent = """
---
date: 2022-04-04 09:00
description: swift-async-algorithms プロトタイプリリース、リーダーアプリのアカウント管理についての更新、iOS 15.4.1リリース、iPadOS 15.4.1リリース、macOS 12.3.1リリース、watchOS 8.5.1リリース
tags: apple, swift, ios, ipados, macos, watchos
---
# 001 2022-04-04

## swift-async-algorithms プロトタイプリリース

[https://twitter.com/SwiftLang/status/1507425192418574337](https://twitter.com/SwiftLang/status/1507425192418574337)

[https://www.swift.org/blog/swift-async-algorithms/](https://www.swift.org/blog/swift-async-algorithms/)

[https://github.com/apple/swift-async-algorithms](https://github.com/apple/swift-async-algorithms)

非同期シーケンスと高度なアルゴリズムのライブラリです。
GitHub にソースが公開され、プロトタイプがリリースされました。

## リーダーアプリのアカウント管理についての更新
"""
    
    // MARK: - PostDetails
    
    func testModifyPost() {
        // TODO: Body の出力を確認するテスト(検討中
    }
    
    func testWithoutModifyPost() {
        let contentWithoutDescription = viewModel.modifyPost("")
        let expectedValue = ""
        XCTAssertEqual(
            contentWithoutDescription,
            expectedValue
        )
    }
}
