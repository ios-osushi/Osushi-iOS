import Foundation

final class DetailPostViewModel {
    func modifyPost(_ content: String) -> String {
        let parts = content.components(separatedBy: "---")
        guard parts.count > 2 else { return content }
        return parts[2...].joined(separator: "---")
    }
}
