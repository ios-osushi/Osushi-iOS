import SwiftUI

struct StaffListView: View {
    let profiles: [Profile]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(profiles) { profile in
                    NavigationLink {
                        ProfileDetailView(profile: profile)
                    } label: {
                        ProfileRowView(profile: profile)
                    }
                }
            }
            .navigationTitle(Strings.Infomation.staffListTitle)
        }
    }
}
