//
//  ExplainTrainingViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit

class ExplainTrainingViewController: UIViewController {
    @IBOutlet weak var ExplainTraining_LBL_title: UILabel!
    @IBOutlet weak var ExplainTraining_IMG_image: UIImageView!
    @IBOutlet weak var ExplainTraining_LBL_timer: UILabel!
    var currentPlan :[Step] = [Step]()
    var index : Int!
    var timer:Timer?
    var timeLeft = 10
    var type :String!
    var pressedStop : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        setInfo()
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        ExplainTraining_LBL_timer.text = "\(timeLeft) seconds to start..."

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            print("nowwww1  -------\(self.pressedStop)")
            if(self.pressedStop){
                performSegue(withIdentifier: "goToTimer", sender: self)
            }
        }
    }
    
    
    func setInfo(){
        ExplainTraining_LBL_title.text = "Step \(index+1) - \(currentPlan[index].nameOfStep!) - 30 sec"
        ExplainTraining_IMG_image.image = currentPlan[index].pic!
    }
    
 // MARK: - check why that i come back to menu the timer still running
    @IBAction func stpTraining(_ sender: UIButton) {
        self.pressedStop = false
//        print("nowwww2  -------\(self.pressedStop ?? true)")
        performSegue(withIdentifier: "stopExplainAndGoToPlans", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       if(segue.identifier == "goToTimer"){
            let timerView = segue.destination as! TimerViewController
            timerView.currentPlan = currentPlan
            timerView.index = index
            timerView.type = type
        }
    }
    

}
