//
//  TrainingViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {

    @IBOutlet weak var Training_LBL_title: UILabel!
    @IBOutlet weak var Training_LBL_description: UILabel!
    var currentPlan :[Step] = [Step]()
    var planTitle :String?
    var index :Int = 0
    var type : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()

    }
    
    func setInfo(){
        Training_LBL_title.text = planTitle
        Training_LBL_description.font = UIFont(name: "Marker felt", size: 30)
        for i in 0..<currentPlan.count{
            Training_LBL_description.text! += "\(i+1). \(currentPlan[i].nameOfStep!)\n"
        }
        
    }
    
    @IBAction func startTraining(_ sender: UIButton) {
        performSegue(withIdentifier: "goToExplainTraining", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "goToExplainTraining"){
            let explainTrainingView = segue.destination as! ExplainTrainingViewController
            explainTrainingView.currentPlan = currentPlan
            explainTrainingView.index = index
            explainTrainingView.type = type
        }
    }
    

}
