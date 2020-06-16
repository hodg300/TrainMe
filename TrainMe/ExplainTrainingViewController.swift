
import UIKit

class ExplainTrainingViewController: UIViewController {
    @IBOutlet weak var ExplainTraining_LBL_title: UILabel!
    @IBOutlet weak var ExplainTraining_IMG_image: UIImageView!
    @IBOutlet weak var ExplainTraining_LBL_timer: UILabel!
    var currentPlan :[Step] = [Step]()
    var index : Int!
    var timer:Timer?
    var timeLeft = 5
    var plan :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()

    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        ExplainTraining_LBL_timer.text = "\(timeLeft) seconds to start..."

        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            performSegue(withIdentifier: "goToTimer", sender: self)
        }
    }
    
    
    func setInfo(){
        ExplainTraining_LBL_title.text = "Step \(index+1) - \(currentPlan[index].nameOfStep!) - 30 sec"
        ExplainTraining_IMG_image.image = currentPlan[index].pic!
    }
    

    @IBAction func stpTraining(_ sender: UIButton) {
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
            timerView.plan = plan
        }
    }
    

}
