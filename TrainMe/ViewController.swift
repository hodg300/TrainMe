
import UIKit
import FirebaseUI
import Firebase



class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       

    }
    
   
    
   
    @IBAction func login(_ sender: UIButton) {
       FirebaseApp.configure()
              let authUI = FUIAuth.defaultAuthUI()
              // You need to adopt a FUIAuthDelegate protocol to receive callback
              authUI?.delegate = self
              let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
              authUI?.providers = providers
              let authViewController = authUI!.authViewController()
              present(authViewController,animated: true,completion: nil)
    }
    
}

extension ViewController : FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil{
            return
        }
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
}



