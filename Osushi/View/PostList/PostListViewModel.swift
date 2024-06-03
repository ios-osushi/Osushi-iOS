import Foundation

final class PostListViewModel: ObservableObject {
    @Published var posts: [String] = []
    
    private var modelData = APIModelData()
    
    init() {
    }
    
    var sortedPosts: [String] {
        let posts = modelData.markdownContent
        return posts.sorted(by: >)
    }
    
    func fetchPosts() {
        modelData.fetchPostsIfNeeded()
        modelData.$markdownContent.assign(to: &$posts)
    }
    
    // MARK: Post row

    func descriptText(_ content: String) -> String {
        let lines = content.components(separatedBy: "\n")
        for line in lines {
            if line.starts(with: "description:") {
                return line
                    .replacingOccurrences(of: "description:", with: "")
                    .trimmingCharacters(in: .whitespaces)
            }
        }
        return "詳細情報が見つかりません。"
    }
}
