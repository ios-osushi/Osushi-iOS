import Foundation

// GitHub APIレートリミットエラーをハンドリングするための構造体
struct RateLimitError: Codable {
    let message: String
    let documentationUrl: String
}
