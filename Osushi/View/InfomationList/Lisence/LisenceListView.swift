import SwiftUI

// TODO: I'm considering supporting this with a library I have created.
struct LisenceListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(
                    "MarkdownUI",
                    destination: LisenceView(
                        title: "MarkdownUI",
                        lisenceBody: """
The MIT License (MIT)

Copyright (c) 2020 Guillermo Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
""",
                        urlString: "https://github.com/gonzalezreal/swift-markdown-ui"
                    )
                )
            }
            .navigationTitle("ライセンス")
        }
    }
}

#Preview {
    LisenceListView()
}
