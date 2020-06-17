

import UIKit
import Firebase

class PlansViewController: UIViewController {

    var plans = [String() : [Step]()]
    var ref: DatabaseReference!
    var time = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPlansDict()
        
        checkExistsing()
        
    }
    
    
    func checkExistsing(){
        self.ref = Database.database().reference().child("users")

              ref.observeSingleEvent(of: .value, with: { (snapshot) in

                  if snapshot.hasChild(Auth.auth().currentUser!.uid){
                  }else{
                    self.ref.child(Auth.auth().currentUser!.uid).setValue(Auth.auth().currentUser?.uid)
                  }
              })
    }
    
    func createPlansDict(){
        plans = ["A" : [Step(nameOfStep: "Chest - Push Ups",pic: #imageLiteral(resourceName: "pushups"),rounds: 3,mul: 1),Step(nameOfStep: "Chest - Elevated Push Ups", pic:#imageLiteral(resourceName: "Elevated Push Ups"),rounds: 3,mul: 1),Step(nameOfStep: "Chest - Incline Pushups", pic:#imageLiteral(resourceName: "incline-push-up") ,rounds: 3,mul: 1),Step(nameOfStep: "Triceps - Bench Dip With Elevated Legs",pic: #imageLiteral(resourceName: "triceps"),rounds: 3,mul: 1),Step(nameOfStep: "Triceps - Bow",pic: #imageLiteral(resourceName: "dips - ios"),rounds: 3,mul: 1),Step(nameOfStep: "Triceps - Dips",pic: #imageLiteral(resourceName: "dips"),rounds: 3,mul: 1),Step(nameOfStep: "Stomach - Sit Ups",pic: #imageLiteral(resourceName: "stomach  - sit ups"),rounds: 3,mul: 1),Step(nameOfStep: "Stomach - Vertical Leg Crunches",pic: #imageLiteral(resourceName: "stomach  - Vertical Leg Crunches"),rounds: 3,mul: 1),Step(nameOfStep: "Stomach - Plank",pic: #imageLiteral(resourceName: "stomach  - plank"),rounds: 3,mul: 1)],
                 "B":[Step(nameOfStep:"Back - Pull Ups",pic:#imageLiteral(resourceName: "pull ups"),rounds: 3,mul: 1),Step(nameOfStep:"Back - Supermans",pic:#imageLiteral(resourceName: "supermans"),rounds: 3,mul: 1),Step(nameOfStep:"Back - Lying Back Extension",pic:#imageLiteral(resourceName: "Lying Back Extension"),rounds: 3,mul: 1),Step(nameOfStep:"Biceps - Bottle Bicep Curls ",pic:#imageLiteral(resourceName: "Bottle_Bicep_Curls"),rounds: 3,mul: 2),Step(nameOfStep:"Biceps - Chin Ups" ,pic:#imageLiteral(resourceName: "biceps - p"),rounds: 3,mul: 1)],
                 "C":[Step(nameOfStep:"Legs - Squat",pic: #imageLiteral(resourceName: "squat"),rounds: 3,mul: 1),Step(nameOfStep:"Legs - Lunges",pic: #imageLiteral(resourceName: "lunges"),rounds: 3,mul: 2),Step(nameOfStep:"Shoulder - Plank Shoulder Taps",pic:#imageLiteral(resourceName: "shoulder"),rounds: 3,mul: 2),Step(nameOfStep:"Shoulder - Pike Push Ups",pic:#imageLiteral(resourceName: "shoulder - pike push ups"),rounds: 3,mul: 1)]]
    }
    
    @IBAction func choosePlan(_ sender: UIButton) {
        if(sender.tag == 1){
            performSegue(withIdentifier: "goToPlanA", sender: self)
        }else if(sender.tag == 2){
            performSegue(withIdentifier: "goToPlanB", sender: self)
        }else if(sender.tag == 3){
            performSegue(withIdentifier: "goToPlanC", sender: self)
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
          if(segue.identifier == "goToPlanA"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["A"]!
            trainingView.planTitle = "Plan A"
            trainingView.plan = "A"
            trainingView.timeOfOneStep = self.time
        }else if(segue.identifier == "goToPlanB"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["B"]!
            trainingView.planTitle = "Plan B"
            trainingView.plan = "B"
            trainingView.timeOfOneStep = self.time
        }else if(segue.identifier == "goToPlanC"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["C"]!
            trainingView.planTitle = "Plan C"
            trainingView.plan = "C"
            trainingView.timeOfOneStep = self.time
        }
        
    }
    

}
