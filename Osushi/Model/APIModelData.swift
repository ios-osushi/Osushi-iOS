import Foundation

final class APIModelData: ObservableObject {
    @Published var markdownContents: [String] = []
    @Published var errorMessage: String = "不明なエラー"
    
    private var lastFetchDate: Date?
    private let fetchThresholdSeconds: TimeInterval = 3600 // 1hour
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    private static let githubApiQuery = [
        URLQueryItem(name: "client_id", value: Key.clientId),
        URLQueryItem(name: "client_secret", value: Key.clientSecret)
    ]
    
    func fetchPostsIfNeeded() {
        Task {
            let now: Date = .now
            if let lastFetchDate {
                guard now.timeIntervalSince(lastFetchDate) > fetchThresholdSeconds else {
                    print("取得できませんでした。：\(now.timeIntervalSince(lastFetchDate))")
                    return
                }
            }
            await fetchPosts()
            lastFetchDate = now
        }
    }
    
    @MainActor
    private func fetchPosts() async {
        markdownContents.removeAll()
        guard var url = URL(string: Url.osushiApi) else { return }
        url.append(queryItems: APIModelData.githubApiQuery)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // APIエラーレスポンスのハンドリング
            if let rateLimitError = try? decoder.decode(RateLimitError.self, from: data) {
                errorMessage = rateLimitError.message
                return
            }
            
            if let response = try? decoder.decode([Post].self, from: data) {
                // TaskGroupを使用して並列処理する
                await withTaskGroup(of: Void.self) { group in
                    for post in response {
                        group.addTask {
                            await self.fetchDownloadUrl(post.downloadUrl)
                        }
                    }
                }
            }
        } catch {
            errorMessage = "API Request Failed: \(error.localizedDescription)"
        }
    }
    
    @MainActor
    private func fetchDownloadUrl(_ downloadUrl: String) async {
        if downloadUrl == Url.indexDownload { return }
        guard let url = URL(string: downloadUrl) else {
            fatalError("Invalid Url")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let markdownString = String(data: data, encoding: .utf8) else { return }
            markdownContents.append(markdownString)
        } catch {
            fatalError("API Request Failed: \(error.localizedDescription)")
        }
    }
}
