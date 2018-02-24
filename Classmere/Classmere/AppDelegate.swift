import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let store = Store(provider: URLSessionProvider())
        let homeViewController = HomeViewController(store: store)
        let navigationController = UINavigationController(rootViewController: homeViewController)

        UINavigationBar.appearance().isTranslucent = false

        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true
    }

}
