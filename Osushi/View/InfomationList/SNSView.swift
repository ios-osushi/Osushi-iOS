import SwiftUI

struct SNSView: View {
    let xUrlString: String
    let gitHubUrlString: String
    
    var body: some View {
        Link("X", destination: URL(string: xUrlString)!)
        Link("GitHub", destination: URL(string: gitHubUrlString)!)
    }
}
