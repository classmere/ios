import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var classmereLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        classmereLabel.attributedText = Theme.classmereLogo(withSize: 17)
    }

    @IBAction func rutgerfarryButtonPressed(_ sender: Any) {
        let url = URL(string: "https://twitter.com/rutgerfarry")!
        UIApplication.shared.open(url, options: [:])
    }

    @IBAction func brandonlee503ButtonPressed(_ sender: Any) {
        let url = URL(string: "https://github.com/brandonlee503")!
        UIApplication.shared.open(url, options: [:])
    }

}
