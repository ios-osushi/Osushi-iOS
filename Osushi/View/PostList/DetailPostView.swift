import SwiftUI
import MarkdownUI
import SwiftData
import TipKit

struct FavoriteButtonTip: Tip {
    var title: Text {
        Text("お気に入りボタン")
    }
    var message: Text? {
        Text("この記事をお気に入りすることができます🍣\nお気に入りした記事は下のタブから確認することができます！")
    }
}

struct DetailPostView: View {
    let viewModel = DetailPostViewModel()
    var markdownContent: String

    @Environment(\.modelContext) private var context
    @Query private var favoritePosts: [Favorite]
    @State private var isFavorited = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Markdown(viewModel.modifyPost(markdownContent))
                    .markdownTheme(.gitHub)
                    .padding()
            }
            .toolbar {
                Image(systemName: isFavorited ? "star.fill" : "star")
                    .foregroundStyle(isFavorited ? .yellow : .gray)
                    .phaseAnimator([1, 2], trigger: isFavorited) { content, phase in
                        content.scaleEffect(phase)
                    }
                    .onTapGesture {
                        FavoriteButtonTip()
                            .invalidate(reason: .actionPerformed)
                        tappedFavoriteButton()
                    }
                    .popoverTip(FavoriteButtonTip())
.sensoryFeedback(.impact, trigger: isFavorited)
                        new == true
                    }
            }
        }
        .task {
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault),
            ])
        }
        .onAppear {
            setupData()
        }
    }
    
    private func tappedFavoriteButton() {
        isFavorited.toggle()
        if isFavorited {
            add(post: markdownContent)
        } else {
            delete(post: markdownContent)
        }
    }
    
    private func setupData() {
        for favoritePost in favoritePosts {
            if favoritePost.post == markdownContent {
                isFavorited = true
            }
        }
    }
    
    private func add(post: String) {
        let data = Favorite(post: post)
        context.insert(data)
    }
    
    private func delete(post: String) {
        // 保存されている`Favorite`オブジェクトの中から、指定した`post`と一致する全てのオブジェクトを検索する。
        let toBeDeleted = favoritePosts.filter { $0.post == post }
        
        // 検索によって見つかったオブジェクトを削除する。
        for deleteItem in toBeDeleted {
            context.delete(deleteItem)
        }
        
        // 変更を保存する。
        do {
            try context.save()
        } catch {
            // TODO: アラートを表示
            print("削除時にエラーが発生しました: \(error)")
        }
    }
}

#Preview {
    DetailPostView(markdownContent: """
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

[https://developer.apple.com/jp/news/?id=grjqafts](https://developer.apple.com/jp/news/?id=grjqafts)

リーダーアプリから、アカウントの作成や管理を行える Web サイトへリンクできるようになりました。

## iOS 15.4.1リリース

[https://developer.apple.com/news/releases/?id=03312022d](https://developer.apple.com/news/releases/?id=03312022d)

## iPadOS 15.4.1リリース

[https://developer.apple.com/news/releases/?id=03312022c](https://developer.apple.com/news/releases/?id=03312022c)

## macOS 12.3.1リリース

[https://developer.apple.com/news/releases/?id=03312022e](https://developer.apple.com/news/releases/?id=03312022e)

## watchOS 8.5.1リリース

[https://developer.apple.com/news/releases/?id=03312022b](https://developer.apple.com/news/releases/?id=03312022b)
""")
    .modelContainer(for: Favorite.self)
}
