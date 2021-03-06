@testable import Interval

class SpotifyClientMock: SpotifyClientType {
    var delegate: SpotifyClientDelegate?
        
    private let isAuthenticated: Bool
    private let isAppInstalled: Bool
    
    var isSpotifyAppInstalled: Bool {
        return isAppInstalled
    }
    
    var isUserAuthenticated: Bool {
        return isAuthenticated
    }
    
    init(isAuthenticated: Bool, isAppInstalled: Bool) {
        self.isAuthenticated = isAuthenticated
        self.isAppInstalled = isAppInstalled
    }
    
    func connect() {
        //
    }
}
