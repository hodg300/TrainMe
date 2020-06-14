
import UIKit
import Firebase

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var history_TBL_tableView: UITableView!
    let users = "users"
    let cellReuseIdentifier = "name_cell"
    var ref: DatabaseReference!
    var dataList :[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDataFromFirebase()
        history_TBL_tableView.delegate = self
        history_TBL_tableView.dataSource = self
       
    }
    
    func loadDataFromFirebase(){
        ref = Database.database().reference().child(users).child(String(Auth.auth().currentUser!.uid))
                ref.observe(.childAdded, with: { snapshot in
                    self.dataList.append(snapshot.value as! String)
                    self.history_TBL_tableView.reloadData()
                    print("\(self.dataList)")
                })
        
    }
    
    //number of row in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    //create every cell and assume the text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MyCustomCell? = self.history_TBL_tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MyCustomCell
        cell?.MyCustomCell_LBL_cell?.text = "\(indexPath.row + 1). \(dataList[indexPath.row])"
        print("\(dataList[indexPath.row])")
        
        if(cell == nil){
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }
    

}
