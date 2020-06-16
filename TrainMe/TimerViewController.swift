//
//  TimerViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
class TimerViewController: UIViewController {

    @IBOutlet weak var Timer_LBL_trainingTimer: UILabel!
    @IBOutlet weak var Timer_LBL_rest: UILabel!
    var timer:Timer?
    var timeLeft = 10
    var index : Int!
    var plan : String!
    var currentPlan :[Step] = [Step]()
    var ref: DatabaseReference!
    var boolRest : Bool = false
    var dataList = [String]()
    var audioPlayer : AVAudioPlayer!


    override func viewDidLoad() {
        super.viewDidLoad()
        index += 1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        
    }
    func playBackgorundMusic(counter:Int) {
        if(counter > 0 && counter <= 5){
            let pathToSound = Bundle.main.path(forResource: "\(counter)", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                //play background music in loop
                audioPlayer.numberOfLoops = 0
                audioPlayer.play();
                print("song now---------------------\(counter)")
            } catch {
                //Error handling.
                print("Couldn't find sound file...")
            }
        }
    }
    


    @objc func onTimerFires()
    {
        timeLeft -= 1
        Timer_LBL_trainingTimer.text = "\(timeLeft) seconds"
        playBackgorundMusic(counter: timeLeft)
        if timeLeft <= 0 {
            if(boolRest == false){
                timeLeft = 10
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
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    let now = df.string(from: Date())
                    print("\(now)")
                    ref.childByAutoId().setValue(["plan":plan!,"date":now])
                    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToAnotherStepExplain"){
            let explainTrainingView = segue.destination as! ExplainTrainingViewController
            explainTrainingView.currentPlan = currentPlan
            explainTrainingView.index = index
            explainTrainingView.plan = plan
        }
    }
    

}
