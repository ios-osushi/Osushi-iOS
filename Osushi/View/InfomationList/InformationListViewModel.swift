import Foundation

final class InformationListViewModel {
    static let xUrlString = "https://twitter.com/ios_osushi"
    static let gitHubUrlString = "https://github.com/ios-osushi"
    
    static var profiles: [Profile] = [
        Profile(id: 1, name: "Uhooi", imageName: "uhooi", x: "the_uhooi", gitHub: "uhooi"),
        Profile(id: 2, name: "treastrain", imageName: "treastrain", x: "treastrain", gitHub: "treastrain"),
        Profile(id: 3, name: "hcrane14", imageName: "hcrane14", x: "hcrane14", gitHub: "crane-hiromu"),
        Profile(id: 4, name: "ry_itto", imageName: "ry_itto", x: "ry_itto", gitHub: "ry-itto"),
        Profile(id: 5, name: "_tomu28", imageName: "tomu28", x: "_tomu28", gitHub: "tomu28"),
        Profile(id: 6, name: "とんとんぼ", imageName: "tonfly", x: "Ktombow1110", gitHub: "KaitoMuraoka"),
    ]
    
    var versionString: String {
        let version = makeVersionString(forInfoDictionaryKey: "CFBundleShortVersionString")
        let build = makeVersionString(forInfoDictionaryKey: "CFBundleVersion")
        return "\(version)(\(build))"
    }
    
    private func makeVersionString(forInfoDictionaryKey key: String) -> String {
        Bundle.main.object(forInfoDictionaryKey: key) as? String ?? "不明"
    }
}
