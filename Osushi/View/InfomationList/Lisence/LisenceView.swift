import SwiftUI
import MarkdownUI

struct LisenceView: View {
    let title: String
    let lisenceBody: String
    let urlString: String
    
    var body: some View {
        Link(title, destination: url)
            .font(.title)
        
        ScrollView {
            Markdown(lisenceBody)
                .padding()
        }
    }
    
    private var url: URL {
        URL(string: urlString)!
    }
}
