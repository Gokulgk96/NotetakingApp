//
//  Delete_ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 26/01/22.
//

import UIKit
import Firebase

class Delete_ViewController: UIViewController {

    @IBOutlet weak var Table_View_work: UITableView!
    
   var To_Delete = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delete your cell!"
        Retrieving_data()
      
    }
    
    @IBAction func Cancel_Button(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Delete_Button(_ sender: Any) {
        
        if(To_Delete.count == 0)
        {
            // create the alert
                  let alert = UIAlertController(title: "Error", message: "You havn't Selected it", preferredStyle: UIAlertController.Style.alert)

         
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil ))

                  // show the alert
                  self.present(alert, animated: true, completion: nil)
        }
        
         
         // create the alert
               let alert = UIAlertController(title: "Need to DELETE ?", message: "ONCE DELETED WILL NOT BE RETRIEVED", preferredStyle: UIAlertController.Style.alert)

               // add an action (button)
         alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { _ in
             
            for i in self.To_Delete  {
             
                rootRef.child(i).setValue(nil)
            }
            
             self.navigationController?.popViewController(animated: true)
             
             
         }))
         
         alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil ))

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }
    
    func Retrieving_data()
    {
        To_Delete.removeAll()
        Deleting_datas.removeAll()
        
        rootRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
            if snapshot.childrenCount > 0
            {
    
                for Unpinned_data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let Object = Unpinned_data.value as? NSDictionary
                 
           Deleting_datas.append(Del_Caller.init(title: Object!["title"] as! String, serial_number: Object!["Serial_number"] as! String))
                    
                }
            }
            
            self.Table_View_work.reloadData()
          
            })
      
    }

    

}

extension Delete_ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = .systemRed
        
        To_Delete.append(Deleting_datas[indexPath.row].serial_number)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Deleting_datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom_Table_view", for: indexPath) as! Custom_TableTableViewCell
        
        cell.set(Label: Deleting_datas[indexPath.row].title!)
        
        return cell
    }
    
    
}
