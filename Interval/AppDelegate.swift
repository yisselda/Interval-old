import UIKit

private let SpotifyClientID = "2ab7f90f49a741c9a384b014163fd95b"
private let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    private lazy var configuration: SPTConfiguration = {
        return SPTConfiguration(clientID: SpotifyClientID,
                                redirectURL: SpotifyRedirectURL)
    }()
    
    private lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://interval-spotify-auth.herokuapp.com/token"),
            let tokenRefreshURL = URL(string: "https://interval-spotify-auth.herokuapp.com/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        
        return SPTSessionManager(configuration: self.configuration, delegate: self)
    }()
    
    private lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
//        appRemote.connectionParameters.accessToken = "BQBnC9iGlFhBXYD7YM6CkWUQH-_tcU3XdYUaAJy3MnMp9DmbxWP5F9c2dqinSvWedCLVbjvhvEzddD-KGgiRqRFlFWg8S-cgNRf0pi7uPg0Iyke3i0cFPD5roj-KYZ57qgngrYeXjpsZQbeDH0UPKnTq3OgnwaHU6d6YTwy2Yg"
        return appRemote
    }()
    
    // MARK: - Application Lifecycle Methods
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let requestedScopes: SPTScope = [.appRemoteControl]
        self.sessionManager.initiateSession(with: requestedScopes, options: .default)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        self.sessionManager.application(app, open: url, options: options)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let _ = self.appRemote.connectionParameters.accessToken {
            self.appRemote.connect()
        }
    }
    
}

// MARK: - Session Delegate Methods

extension AppDelegate: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        self.appRemote.connectionParameters.accessToken = session.accessToken
        self.appRemote.connect()
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        debugPrint(session)
    }
}

// MARK: - App Remote Delegate Methods

extension AppDelegate: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
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

// MARK: - Player State Delegate Methods

extension AppDelegate: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Track name: %@", playerState.track.name)
    }
}
