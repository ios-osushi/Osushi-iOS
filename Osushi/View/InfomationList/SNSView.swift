import SwiftUI

struct SNSView: View {
    let xUrlString: String
    let gitHubUrlString: String
    
    var body: some View {
        Link(Strings.Infomation.x, destination: URL(string: xUrlString)!)
        Link(Strings.Infomation.gitHub, destination: URL(string: gitHubUrlString)!)
    }
}
