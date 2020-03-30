import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Properties
  
  var window: UIWindow?
  var rootCoordinator: RootCoordinator?
  
  // MARK: - Application Lifecycle Methods
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navigationController = UINavigationController()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    rootCoordinator = RootCoordinator(navigationController: navigationController)
    rootCoordinator?.start()
    
    return true
  }
  
  func application(_ app: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    SpotifyClient.shared.sessionManager.application(app, open: url, options: options)
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    //
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    
  }
}
