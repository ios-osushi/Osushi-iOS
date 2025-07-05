import SwiftData

@Model
final class Favorite {
    var post: String
    
    init(post: String) {
        self.post = post
    }
}
