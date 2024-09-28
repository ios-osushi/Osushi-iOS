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
                    NavigationLink(Strings.Infomation.management) {
                        StaffListView(profiles: InformationListViewModel.profiles)
                    }
                    NavigationLink(Strings.Infomation.license) {
                        LisenceListView()
                    }
                }
                
                Section {
                    LabeledContent(Strings.Infomation.version, value: viewModel.versionString)
                }
            }
            .navigationTitle(Strings.Infomation.title)
        }
    }
}

#Preview {
    InfoListView()
}
