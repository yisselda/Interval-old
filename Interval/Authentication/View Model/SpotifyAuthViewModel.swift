protocol SpotifyAuthViewModelType: class {
    func connect()
    var delegate: SpotifyAuthViewModelDelegate? { get set }
}

protocol SpotifyAuthViewModelDelegate {
    func didConnect()
}

class SpotifyAuthViewModel: SpotifyAuthViewModelType {
    var delegate: SpotifyAuthViewModelDelegate?
    
    private var spotifyClient: SpotifyClientType
    
    init(spotifyClient: SpotifyClientType) {
        self.spotifyClient = spotifyClient
        self.spotifyClient.delegate = self
    }
    
    func connect() {
        return spotifyClient.connect()
    }
}

extension SpotifyAuthViewModel: SpotifyClientDelegate {
    func didConnect() {
        delegate?.didConnect()
    }
}
