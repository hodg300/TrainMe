//
//  HistoryViewController.swift
//  TrainMe
//
//  Created by user165563 on 6/12/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var history_TBL_tableView: UITableView!
    
    var historyOfTraining:[Training] = []
    let cellReuseIdentifier = "name_cell"
    var ref: DatabaseReference!
    var dataList :[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDataFromFirebase()
        history_TBL_tableView.delegate = self
        history_TBL_tableView.dataSource = self
       
    }
    
    func loadDataFromFirebase(){
        ref = Database.database().reference().child("Users").child(String(Auth.auth().currentUser!.uid))
                ref.observe(.childAdded, with: { snapshot in
                    self.dataList = snapshot.value as! [String]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
