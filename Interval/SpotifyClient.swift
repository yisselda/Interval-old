//  private let SpotifyClientID = "2ab7f90f49a741c9a384b014163fd95b"
//  private let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
//
//  private lazy var configuration: SPTConfiguration = {
//    return SPTConfiguration(clientID: SpotifyClientID,
//                            redirectURL: SpotifyRedirectURL)
//  }()
//
//  private lazy var sessionManager: SPTSessionManager = {
//    if let tokenSwapURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/token"),
//      let tokenRefreshURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/refresh_token") {
//      self.configuration.tokenSwapURL = tokenSwapURL
//      self.configuration.tokenRefreshURL = tokenRefreshURL
//      self.configuration.playURI = "spotify:track:6194J9U7xviKfo0ZSsnxIc"
//    }
//
//    return SPTSessionManager(configuration: self.configuration, delegate: self)
//  }()
//
//  private lazy var appRemote: SPTAppRemote = {
//    let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
//    appRemote.delegate = self
//    return appRemote
//  }()
//
//  init() {
//  let requestedScopes: SPTScope = [.appRemoteControl]
//  self.sessionManager.initiateSession(with: requestedScopes, options: .default)
//  }

//// MARK: - Session Delegate Methods
//
//extension AppDelegate: SPTSessionManagerDelegate {
//  func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
//    self.appRemote.connectionParameters.accessToken = session.accessToken
//    self.appRemote.connect()
//  }
//
//  func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//    debugPrint(error.localizedDescription)
//  }
//
//  func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
//    debugPrint(session)
//  }
//}
//
//// MARK: - App Remote Delegate Methods
//
//extension AppDelegate: SPTAppRemoteDelegate {
//  func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//    self.appRemote.playerAPI?.delegate = self
//    self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
//      if let error = error {
//        debugPrint(error.localizedDescription)
//      }
//    })
//  }
//
//  func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//    debugPrint("Connection failed")
//  }
//
//  func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//    debugPrint("Connection disconnected")
//  }
//}
//
//// MARK: - Player State Delegate Methods
//
//extension AppDelegate: SPTAppRemotePlayerStateDelegate {
//  func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//    debugPrint("Track name: %@", playerState.track.name)
//  }
//}


private struct Constants {
  static let SpotifyClientID = "2ab7f90f49a741c9a384b014163fd95b"
  static let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")
  static let tokenSwapURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/token")!
  static let tokenRefreshURL = URL(string: "https://interval-spotify-auth.herokuapp.com/api/refresh_token")!
}

protocol SpotifyClientType {
    var isSpotifyAppInstalled: Bool { get }
    var isUserAuthenticated: Bool { get }
}

class SpotifyClient: NSObject, SpotifyClientType {
  
  static let shared = SpotifyClient()
  
  private lazy var configuration: SPTConfiguration = {
    
    guard let url = Constants.SpotifyRedirectURL else {
      fatalError("Spotify redirect URL was misconfigured, failing URL: \(String(describing: Constants.SpotifyRedirectURL))")
    }
    
    let configuration =  SPTConfiguration(clientID: Constants.SpotifyClientID, redirectURL: url)
    configuration.tokenSwapURL = Constants.tokenSwapURL
    configuration.tokenRefreshURL = Constants.tokenRefreshURL
    return configuration
  }()
  
  private lazy var sessionManager: SPTSessionManager = {
      return SPTSessionManager(configuration: configuration, delegate: self)
  }()
  
  private override init() {
    super.init()
  }
  
  func isSpotifyAppInstalled() -> Bool {
    return sessionManager.isSpotifyAppInstalled
  }
}

extension SpotifyClient: SPTSessionManagerDelegate {
  func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
    //
  }
  
  func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
    //
  }
}
