import Quick
import Nimble
@testable import Interval

class RootCoordinatorSpec: QuickSpec {
    override func spec() {
        var subject: RootCoordinator!
        
        describe("start()") {
            context("when the user is not authenticated") {
                beforeEach {
                    subject = self.unAuthenticatedSubject
                    subject.start()
                }
                it("should display the login view controller") {
                    expect(subject.topViewController).to(beAKindOf(SpotifyAuthViewController.self))
                }
            }
        }
    }
}

private extension RootCoordinatorSpec {
    var unAuthenticatedSubject: RootCoordinator {
        return RootCoordinator(
            navigationController: UINavigationController(),
            spotifyClient: SpotifyClientMock(
                isAuthenticated: false,
                isAppInstalled: false
            )
        )
    }
}
