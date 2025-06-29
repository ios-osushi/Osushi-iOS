import SwiftUI

struct SNSView: View {
    let xUrlString: String
    let gitHubUrlString: String
    
    var body: some View {
        Link("X", destination: URL(string: xUrlString)!)// swiftlint:enable force_unwrapping
        Link("GitHub", destination: URL(string: gitHubUrlString)!) // swiftlint:enable force_unwrapping
    }
}
