//
//  PlansViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController {

    var plans = [String() : [Step]()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPlansDict()
    }
    
    func createPlansDict(){
        plans = ["A" : [Step(nameOfStep: "Chest",pic: #imageLiteral(resourceName: "pushups")),Step(nameOfStep: "Tricep",pic: #imageLiteral(resourceName: "triceps")),Step(nameOfStep: "Stomach",pic: #imageLiteral(resourceName: "stomach"))],"B":[Step(nameOfStep:"Back",pic:#imageLiteral(resourceName: "pull ups")),Step(nameOfStep:"Biceps",pic:#imageLiteral(resourceName: "biceps"))],"C":[Step(nameOfStep:"Legs",pic: #imageLiteral(resourceName: "squat")),Step(nameOfStep:"Shoulder",pic:#imageLiteral(resourceName: "shoulder"))]]
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
          if(segue.identifier == "goToPlanA"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["A"]!
            trainingView.planTitle = "Plan A"
            trainingView.type = "A"
        }else if(segue.identifier == "goToPlanB"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["B"]!
            trainingView.planTitle = "Plan B"
            trainingView.type = "B"

        }else if(segue.identifier == "goToPlanC"){
            let trainingView = segue.destination as! TrainingViewController
            trainingView.currentPlan = plans["C"]!
            trainingView.planTitle = "Plan C"
            trainingView.type = "C"

        }
        
    }
    

}
