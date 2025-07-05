import SwiftUI

struct ProfileDetailView: View {
    let profile: Profile
    
    var body: some View {
        NavigationStack {
            Image(profile.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            Text(profile.name)
                .font(.title)
            
            HStack {
                Link(
                    "X",
                    destination: URL(
                        string: "https://twitter.com/\(profile.x)"
                    )!// swiftlint:disable:this force_unwrapping
                )
                
                Link(
                    "GitHub",
                    destination: URL(
                        string: "https://github.com/\(profile.gitHub)"
                    )!// swiftlint:disable:this force_unwrapping
                )
            }
        }
    }
}

#Preview {
    ProfileDetailView(
        profile: Profile(
            id: 1,
            name: "とんとんぼ",
            imageName: "tonfly",
            x: "Ktonbow1110",
            gitHub: "KaitoMuraoka"
        )
    )
}
