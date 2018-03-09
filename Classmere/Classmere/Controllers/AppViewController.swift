import UIKit
import MaterialComponents.MaterialSnackbar

final class AppViewController: UIViewController {

    let rootViewController: UIViewController
    let reachability = Reachability()

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
        addChildViewController(rootViewController)

        view.addSubview(rootViewController.view)

        rootViewController.view.frame = view.bounds
        rootViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        rootViewController.didMove(toParentViewController: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        reachability?.onConnectionChange = { connection in
            if connection == .none {
                DispatchQueue.main.async {
                    self.showSnackbar(withMessage: "Disconnected from Internet", duration: 5)
                }
            }
        }
    }

    func showSnackbar(withMessage message: String, duration: TimeInterval) {
        MDCSnackbarManager.show(MDCSnackbarMessage(text: message))
    }
}
