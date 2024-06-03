import SwiftUI

struct ProfileRowView: View {
    let profile: Profile
    
    var body: some View {
        HStack {
            Image(profile.imageName)
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(profile.name)
        }
    }
}

#Preview {
    ProfileRowView(
        profile: Profile(
            id: 1,
            name: "とんとんぼ",
            imageName: "tonfly",
            x: "Ktonbow1110",
            gitHub: "KaitoMuraoka"
        )
    )
}
