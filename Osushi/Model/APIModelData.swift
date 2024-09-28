import Foundation

final class APIModelData: ObservableObject {
    @Published var markdownContent: [String] = []
    @Published var errorMessage: String = Strings.Other.unknown
    
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
        let now: Date = .now
        if let lastFetchDate {
            guard now.timeIntervalSince(lastFetchDate) > fetchThresholdSeconds else {
                print("取得できませんでした。：\(now.timeIntervalSince(lastFetchDate))")
                return
            }
        }
        fetchPosts()
        lastFetchDate = now
    }
    
    private func fetchPosts() {
        markdownContent.removeAll()
        guard var url = URL(string: Url.osushiApi) else { return }
        url.append(queryItems: APIModelData.githubApiQuery)
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data, let self else { return }
            if let error {
                // TODO: エラー処理をここに記述
                DispatchQueue.main.async {
                    self.errorMessage = "API Request Failed: \(error.localizedDescription)"
                }
                return
            }
            
            // APIエラーレスポンスのハンドリング
            if let rateLimitError = try? self.decoder.decode(RateLimitError.self, from: data) {
                DispatchQueue.main.async {
                    self.errorMessage = rateLimitError.message
                }
                return
            }
            
            if let response = try? self.decoder.decode([Post].self, from: data) {
                DispatchQueue.main.async {
                    for post in response {
                        self.fetchDownloadUrl(post.downloadUrl)
                    }
                }
                return
            }
        }
        .resume()
    }
    
    private func fetchDownloadUrl(_ downloadUrl: String) {
        if downloadUrl == Url.indexDownload { return }
        guard let url = URL(string: downloadUrl) else {
            fatalError("Invalid Url")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            if let error {
                fatalError("API Request Failed: \(error.localizedDescription)")
            }
            
            if let markdownString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    if markdownString.starts(with: " ") { return }
                    self.markdownContent.append(markdownString)
                }
                return
            } else {
                self.markdownContent.append("**エラー**")
                // TODO: アラートを表示
                print("Error fetching markdown content: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        .resume()
    }
}
