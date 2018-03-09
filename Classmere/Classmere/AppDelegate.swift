import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let store = Store(provider: URLSessionProvider())
        let homeViewController = HomeViewController(store: store)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        let appViewController = AppViewController(rootViewController: navigationController)

        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: path) as? [String: String],
            let googleMapsAPIKey = keys["Google Maps API"] {
            GMSServices.provideAPIKey(googleMapsAPIKey)
        }

        UINavigationBar.appearance().isTranslucent = false

        window!.rootViewController = appViewController
        window!.makeKeyAndVisible()

        return true
    }

}
