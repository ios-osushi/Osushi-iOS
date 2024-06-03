import XCTest
@testable import Osushi

final class PostListTests: XCTestCase {
    let viewModel = PostListViewModel()
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
    
    // MARK: - Post row
    
    func testDescriptionExtraction() throws {
        let contentWithDescription = viewModel.descriptText(markdownContent)
        let expectedValue = "swift-async-algorithms プロトタイプリリース、リーダーアプリのアカウント管理についての更新、iOS 15.4.1リリース、iPadOS 15.4.1リリース、macOS 12.3.1リリース、watchOS 8.5.1リリース"
        XCTAssertEqual(
            contentWithDescription,
            expectedValue
        )
    }
    
    func testNilDescriptionExtraction() throws {
        let contentWithoutDescription = viewModel.descriptText("")
        let expectedWithoutValue = "詳細情報が見つかりません。"
        XCTAssertEqual(
            contentWithoutDescription,
            expectedWithoutValue
        )
    }
}
