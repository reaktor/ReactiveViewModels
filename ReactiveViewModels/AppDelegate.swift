import UIKit
import ReactiveViewModelsFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window  = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()

        let navigationController = UINavigationController()
        navigationController.viewControllers = [LoginViewController()]
        window.rootViewController = navigationController

        self.window = window

        return true
    }
}

