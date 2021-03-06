
import UIKit
import FirebaseUI
import Firebase
import FBSDKLoginKit



class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }
    
   
   
    @IBAction func login(_ sender: UIButton) {
           

            let authUI = FUIAuth.defaultAuthUI()
            // You need to adopt a FUIAuthDelegate protocol to receive callback
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [FUIGoogleAuth(),FUIFacebookAuth()]
            authUI?.providers = providers
            let authViewController = authUI!.authViewController()
            
            present(authViewController,animated: true,completion: nil)
        }

    
}

extension LoginViewController : FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil{
            return
        }
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
}



