private struct Constants {
    static let SpotifyClientID = "2ab7f90f49a741c9a384b014163fd95b"
    static let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")
    static let tokenSwapURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/token")!
    static let tokenRefreshURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/refresh_token")!
}

protocol SpotifyClientType {
    var isSpotifyAppInstalled: Bool { get }
    var isUserAuthenticated: Bool { get }
    var delegate: SpotifyClientDelegate? { get set}
    func connect()
}

protocol SpotifyClientDelegate {
    func didConnect()
}

class SpotifyClient: NSObject, SpotifyClientType {
    var delegate: SpotifyClientDelegate?
    
    
    static let shared = SpotifyClient()
    
    private lazy var configuration: SPTConfiguration = {
        
        guard let url = Constants.SpotifyRedirectURL else {
            fatalError("Spotify redirect URL was misconfigured, failing URL: \(String(describing: Constants.SpotifyRedirectURL))")
        }
        
        let configuration =  SPTConfiguration(clientID: Constants.SpotifyClientID, redirectURL: url)
        configuration.tokenSwapURL = Constants.tokenSwapURL
        configuration.tokenRefreshURL = Constants.tokenRefreshURL
        configuration.playURI = ""
        return configuration
    }()
    
    lazy var sessionManager: SPTSessionManager = {
        return SPTSessionManager(configuration: configuration, delegate: self)
    }()
    
    private lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    
    private override init() {
        super.init()
    }
    
    var isSpotifyAppInstalled:  Bool {
        return sessionManager.isSpotifyAppInstalled
    }
    
    var isUserAuthenticated: Bool {
        return sessionManager.session.flatMap { !$0.isExpired } ?? false
    }
    
    func connect() {
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
    }
}

// MARK: - App Remote Delegate Methods
extension SpotifyClient: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        debugPrint(#function)
        delegate?.didConnect()
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        debugPrint("Connection failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        debugPrint("Connection disconnected")
    }
}

// MARK: - Session Delegate Methods
extension SpotifyClient: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        debugPrint("didInitiate \(#function)")
        DispatchQueue.main.async {[weak self] in
            self?.appRemote.connectionParameters.accessToken = session.accessToken
            self?.appRemote.connect()
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        debugPrint("didFailWith \(#function)")
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        debugPrint("didRenew \(#function)")
    }
    
    func sessionManager(manager: SPTSessionManager, shouldRequestAccessTokenWith code: String) -> Bool {
        debugPrint("received OAuth \(#function)")
        return true
    }
}

// MARK: - Player State Delegate Methods
extension SpotifyClient: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
    }
}


