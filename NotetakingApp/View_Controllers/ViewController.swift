//
//  ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 22/01/22.
//

import UIKit

import Firebase

let rootRef = Database.database().reference().child("Notes")

var bool_Value2: Bool = false


class ViewController: UIViewController {
    

    @IBOutlet weak var Settings_button: UIBarButtonItem!
    
    @IBOutlet weak var Add_Button: UIBarButtonItem!
    
    @IBOutlet weak var Collection_views: UICollectionView!
    
    
    @IBOutlet weak var Pinned_records: UILabel!
    @IBOutlet weak var UnPinned_records: UILabel!
    
    //-----------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "Notes taking App"
        
        Settings_button.tintColor = .black
        Add_Button.tintColor = .systemBlue
        
        bool_Value2 = UserDefaults.standard.bool(forKey: "mySwitch2")
            Retrieving_data()
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
    
        bool_Value2 = UserDefaults.standard.bool(forKey: "mySwitch2")
     
    
        Retrieving_data()
        
        self.Collection_views.reloadData()
       
     
       }
 
    
    //-------------------------------------
    
    
    func Retrieving_data()
    {
        
        Total_datas.removeAll()
        
          
        rootRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
            if snapshot.childrenCount > 0
            {
    
                for Unpinned_data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let Object = Unpinned_data.value as? NSDictionary
                 
                    
                    if(Object!["pinned"] as! Bool)
                    {
                        Pinned_datas.append(Caller.init(title: Object!["title"] as! String , desc: Object!["description"] as! String , pinned: Object!["pinned"] as! Bool , serial_number: Object!["Serial_number"] as! String , on_Top: Object!["on_Top"] as! Bool ))
                        
                    } else if ( Object!["on_Top"] as! Bool)
                    {
                        UnPinned_datas.append(Caller.init(title: Object!["title"] as! String , desc: Object!["description"] as! String , pinned: Object!["pinned"] as! Bool , serial_number: Object!["Serial_number"] as! String , on_Top: Object!["on_Top"] as! Bool ))
                    }else
                    {
                        UnPinned_datas.insert(Caller.init(title: Object!["title"] as! String , desc: Object!["description"] as! String , pinned: Object!["pinned"] as! Bool , serial_number: Object!["Serial_number"] as! String , on_Top: Object!["on_Top"] as! Bool ), at: 0)
                    }
 

    
                  
                    
                }
            }
            
            Total_datas = Pinned_datas + UnPinned_datas
            
            self.UnPinned_records.text = String(UnPinned_datas.count)
            self.Pinned_records.text = String(Pinned_datas.count)
                
            UnPinned_datas.removeAll()
            Pinned_datas.removeAll()
                                                         
                self.Collection_views.reloadData()
            })
      
    }
    
    //-----------------------------------

    
    func pushtoselectedviewcontroller(Serial_number: String)
    {
        guard let vc = storyboard?.instantiateViewController(identifier: "Show_ViewController") as? Show_ViewController
        else
        {
            return
        }
        
        vc.serial_number = Serial_number
        navigationController?.pushViewController(vc, animated: true)
    }


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
           return 20
       }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 20
       }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(Total_datas[indexPath.row].serial_number)
       pushtoselectedviewcontroller(Serial_number: Total_datas[indexPath.row].serial_number)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return Total_datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom_collection", for: indexPath) as! Custom_CollectionViewCell
        
        cell.edit(labels: Total_datas[indexPath.row].title!, Pin: Total_datas[indexPath.row].pinned)
        
        return cell
        
    }
    
  
 
    
 
    
}




