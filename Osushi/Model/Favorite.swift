import SwiftData

@Model
final class Favorite {
    let post: String
    
    init(post: String) {
        self.post = post
    }
}
