
import UIKit
import FirebaseUI
import Firebase



class LoginViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       

    }
    
   
    
   
    @IBAction func login(_ sender: UIButton) {
        FirebaseApp.configure()
        if(Auth.auth().currentUser == nil){
            let authUI = FUIAuth.defaultAuthUI()
            // You need to adopt a FUIAuthDelegate protocol to receive callback
            authUI?.delegate = self
            let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
            authUI?.providers = providers
            let authViewController = authUI!.authViewController()
            present(authViewController,animated: true,completion: nil)
        }else{
            performSegue(withIdentifier: "goHome", sender: self)
        }
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



