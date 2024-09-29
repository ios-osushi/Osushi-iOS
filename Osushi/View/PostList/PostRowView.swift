import SwiftUI
import MarkdownUI

struct PostRowView: View {
    private let viewModel = PostListViewModel()
    let markdownContent: String
    
    var heading1Text: String {
        let lines = markdownContent.components(separatedBy: "\n")
        for line in lines where  line.starts(with: "# ") {
            return line.replacingOccurrences(of: "# ", with: "").trimmingCharacters(in: .whitespaces)
        }
        return ""
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(heading1Text)
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .underline()
            
            Text(viewModel.descriptText(markdownContent))
                .font(.body)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    Group {
        PostRowView(markdownContent: """
---
date: 2022-04-04 09:00
description: swift-async-algorithms プロトタイプリリース、リーダーアプリのアカウント管理についての更新、iOS 15.4.1リリース、iPadOS 15.4.1リリース、macOS 12.3.1リリース、watchOS 8.5.1リリース
tags: apple, swift, ios, ipados, macos, watchos
---
# 001 2022-04-04

## swift-async-algorithms プロトタイプリリース

[https://twitter.com/SwiftLang/status/1507425192418574337](https://twitter.com/SwiftLang/status/1507425192418574337)

""")
        
        PostRowView(markdownContent: """
---
date: 2022-04-18 09:00
description: Xcode 13.3.1 リリース、ArgumentParser 1.1.2 リリース、Alamofire 5.6.0 リリース、Firebase iOS SDK 8.15.0 リリース、Quick v5.0.0 リリース、ほか
tags: apple, swift, ios, xcode, swift-evolution
---
# 003 2022-04-18

## Xcode 13.3.1 リリース

[Xcode 13.3.1](https://developer.apple.com/news/releases/?id=04112022a)

Swift Concurrency を使用している一部のプロジェクトで、ビットコードを利用してアーカイブすると失敗する不具合が修正されました。

""")
    }
}
