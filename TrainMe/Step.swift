
import Foundation
import UIKit

class Step {
    var nameOfStep : String?
    var pic : UIImage!
    var rounds : Int!
    var mul : Int!
    
    init(nameOfStep : String, pic : UIImage,rounds:Int,mul:Int) {
        self.nameOfStep = nameOfStep
        self.pic = pic
        self.rounds = rounds
        self.mul = mul
    }
    
}
