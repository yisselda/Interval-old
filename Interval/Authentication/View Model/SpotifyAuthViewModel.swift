protocol SpotifyAuthViewModelType: class {
    func connect()
}

class SpotifyAuthViewModel: SpotifyAuthViewModelType {
    private var spotifyClient: SpotifyClientType
    
    init(spotifyClient: SpotifyClientType) {
        self.spotifyClient = spotifyClient
    }
    
    func connect() {
        return spotifyClient.connect()
    }
}
