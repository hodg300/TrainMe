//
//  TimerViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit
import Firebase
class TimerViewController: UIViewController {

    @IBOutlet weak var Timer_LBL_trainingTimer: UILabel!
    @IBOutlet weak var Timer_LBL_rest: UILabel!
    var timer:Timer?
    var timeLeft = 1
    var index : Int!
    var plan : String!
    var currentPlan :[Step] = [Step]()
    var ref: DatabaseReference!
    var boolRest : Bool = false
    var dataList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        index += 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        
    }
    


    @objc func onTimerFires()
    {
        timeLeft -= 1
        Timer_LBL_trainingTimer.text = "\(timeLeft) seconds"
        if timeLeft <= 0 {
            if(boolRest == false){
                timeLeft = 1
                Timer_LBL_rest.text = "Rest..."
                boolRest = true
            }
            else{
                timer?.invalidate()
                timer = nil
                if(index != currentPlan.count){
                    performSegue(withIdentifier: "goToAnotherStepExplain", sender: self)
                }else{
                    //Add the plan to db
                    ref = Database.database().reference().child("users").child(String(Auth.auth().currentUser!.uid))
                    ref.childByAutoId().setValue(plan)
                    
                    Timer_LBL_trainingTimer.text = "Well Done!"
                    let delay : Double = 2.0 //delay time in seconds
                    let time = DispatchTime.now() + delay
                    DispatchQueue.main.asyncAfter(deadline:time){
                    // After 2 seconds this line will be executed
                    self.performSegue(withIdentifier: "goToPlans", sender: self)
                                
                    }
                }
            }
        }
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToAnotherStepExplain"){
            let explainTrainingView = segue.destination as! ExplainTrainingViewController
            explainTrainingView.currentPlan = currentPlan
            explainTrainingView.index = index
            explainTrainingView.plan = plan
        }
    }
    

}
