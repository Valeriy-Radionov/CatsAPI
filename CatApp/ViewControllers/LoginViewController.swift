import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginAction() {
        navigationController?.pushViewController(CatsViewController(), animated: true)
    }
}
