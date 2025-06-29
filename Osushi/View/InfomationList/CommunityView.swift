import SwiftUI

struct CommunityView: View {
    @State private var tapCount = 0
    @State private var isRotate = false
    
    
    var body: some View {
        HStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 400, alignment: .center)
                    .onTapGesture {
                        tapCount += 1
                        withAnimation {
                            isRotate = tapCount % 20 == 0
                        }
                    }
                    .rotationEffect(isRotate ? .degrees(0) : .degrees(360))
                
            
            Spacer()
        }
        Text("iOS Osushiは、iOS関連のニュースを定期的に配信するサイトです。")
    }
}

#Preview {
    CommunityView()
}
