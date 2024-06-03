import Foundation

struct Profile: Codable, Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let x: String // (formerly Twitter)
    let gitHub: String
}
