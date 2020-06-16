
import UIKit
import Firebase

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var history_TBL_tableView: UITableView!
    let users = "users"
    let cellReuseIdentifier = "name_cell"
    var ref: DatabaseReference!
    var plans :[String] = []
    var dates :[String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataFromFirebase()
        history_TBL_tableView.delegate = self
        history_TBL_tableView.dataSource = self
       
    }
    
    func loadDataFromFirebase(){
        ref = Database.database().reference().child(users).child(String(Auth.auth().currentUser!.uid))
                ref.observe(.childAdded, with: { snapshot in
                    var counter = 0
                    for snap in snapshot.children{
                        let block = snap as? DataSnapshot
                        let date = block?.value
                        let plan = block?.value
                        if(counter % 2 == 0 ){
                            self.dates.append(date as! String)
                        }else{
                            self.plans.append(plan as! String)
                        }
                        counter += 1
                        
                    }
                   
                    
//                    self.dataList.append(snapshot.value as! String)
                    self.history_TBL_tableView.reloadData()
                    print("\(self.plans)")
                    print("\(self.dates)")

                })
        
    }
    
    //number of row in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plans.count
    }
    
    //create every cell and assume the text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MyCustomCell? = self.history_TBL_tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MyCustomCell
        cell?.MyCustomCell_LBL_cell?.text = "\(indexPath.row + 1). \(plans[indexPath.row]) - \(dates[indexPath.row])"
        print("\(plans[indexPath.row]) - \(dates[indexPath.row])")
        
        if(cell == nil){
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }
    

}
