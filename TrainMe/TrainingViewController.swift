
import UIKit

class TrainingViewController: UIViewController {

    @IBOutlet weak var Training_LBL_title: UILabel!
    @IBOutlet weak var Training_LBL_description: UILabel!
    @IBOutlet weak var Training_LBL_TimeOfTraining: UILabel!
    var currentPlan :[Step] = [Step]()
    var planTitle :String?
    var index :Int = 0
    var plan : String!
    var timeOfOneStep : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        Training_LBL_TimeOfTraining.text = "\(calculateTimeOfTraining(plan: self.currentPlan))mins"

    }
    
    func calculateTimeOfTraining(plan:[Step]) -> String{
        var result : Int = 0
        var restResult = 0
        var trainingResult = 0
        var minutes = 0;
        var seconds = 0;
        for i in 0..<plan.count{
            trainingResult = currentPlan[i].rounds * timeOfOneStep * currentPlan[i].mul
            restResult = ((currentPlan[i].rounds * currentPlan[i].mul) - 1) * timeOfOneStep
            result += trainingResult + restResult
        }
        minutes = (result % 3600) / 60
        seconds = (result % 3600) % 60
        return "\(minutes):\(seconds)"
    }
    
    func setInfo(){
        Training_LBL_title.text = planTitle
        for i in 0..<currentPlan.count{
            Training_LBL_description.text! += "\(i+1). \(currentPlan[i].nameOfStep!)  X \(currentPlan[i].rounds!)\n"
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
            explainTrainingView.plan = plan
        }
    }
    

}
