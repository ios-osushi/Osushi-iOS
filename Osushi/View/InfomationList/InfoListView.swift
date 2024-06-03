import SwiftUI

struct InfoListView: View {
    private let viewModel = InformationListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    CommunityView()
                }
                
                Section {
                    SNSView(
                        xUrlString: InformationListViewModel.xUrlString,
                        gitHubUrlString: InformationListViewModel.gitHubUrlString
                    )
                }
                
                Section {
                    NavigationLink("運営") {
                        StaffListView(profiles: InformationListViewModel.profiles)
                    }
                    NavigationLink("ライセンス") {
                        LisenceListView()
                    }
                }
                
                Section {
                    LabeledContent("バージョン", value: viewModel.versionString)
                }
            }
            .navigationTitle("iOS Osushi🍣")
        }
    }
}

#Preview {
    InfoListView()
}
