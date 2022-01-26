//
//  Edit_ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 25/01/22.
//

import UIKit

class Edit_ViewController: UIViewController {
    
    var Serial_number: String = ""
    
    @IBOutlet weak var Title_view: UITextField!
    
    @IBOutlet weak var Desc_view: UITextView!
    
    @IBOutlet weak var Share_button: UIButton!
    
    @IBOutlet weak var Pin_Icon_Button: UIButton!
    
    var Pin_Bool : Bool = false
    
    var Pin_count = 0
    
    @IBOutlet weak var Image_view_work: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var boolValue = UserDefaults.standard.bool(forKey: "mySwitch")
      
        Image_view_work.image = UIImage(named: "default_image")
      
        rootRef.child(Serial_number).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let Object = snapshot.value as! NSDictionary
            
            self.Title_view.text = Object["title"] as! String
            
            self.Desc_view.text = Object["description"] as! String
            
            self.Pin_Bool = Object["pinned"] as! Bool
            
            
            if(self.Pin_Bool)
            {
                self.Pin_Icon_Button.setImage(UIImage(systemName: "pin.fill"), for: .normal)
            }else{
                self.Pin_Icon_Button.setImage(UIImage(systemName: "pin"), for: .normal)
            }
            
            
            self.Pin_count = UserDefaults.standard.integer(forKey: "Pin_count")
            
            print("pin_count, Pin_Bool")
            print(self.Pin_count, self.Pin_Bool)
           
            if( self.Pin_count >= 4 && self.Pin_Bool == true)
            {
                self.Pin_Icon_Button.isHidden = false
                
            }else if( self.Pin_count >= 4 && self.Pin_Bool == false)
            {
                self.Pin_Icon_Button.isHidden = true
                
            }else if(self.Pin_count <= 4)
            {
                self.Pin_Icon_Button.isHidden = false
            }
           
            
            
            
        })
        
      
      
          Share_button.isEnabled = boolValue
        
    }
    
    
    @IBAction func Delete_Button(_ sender: Any) {
        
       
        
        // create the alert
              let alert = UIAlertController(title: "Need to DELETE ?", message: "ONCE DELETED WILL NOT BE RETRIEVED", preferredStyle: UIAlertController.Style.alert)

              // add an action (button)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { _ in
            
            if(self.Pin_Bool)
            {
                self.Pin_count -= 1
                
                UserDefaults.standard.set(self.Pin_count, forKey: "Pin_count")
            }
            
            rootRef.child(self.Serial_number).setValue(nil)
            //self.navigationController?.popViewController(animated: true)
            self.navigationController!.popToRootViewController(animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil ))

              // show the alert
              self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func Update_Button(_ sender: Any) {
        
        let insert_value = ["title": Title_view.text! ,"description": Desc_view.text!, "pinned": Pin_Bool, "Serial_number" : Serial_number, "on_Top": Pin_Bool ] as [String : Any]
     
        
    
        rootRef.child(Serial_number).setValue(insert_value)
        
        self.navigationController!.popToRootViewController(animated: true)
        
    }
    
    
    
    @IBAction func Pin_Action(_ sender: Any) {
       
        Pin_Bool = !Pin_Bool
        
        if(Pin_Bool)
        {
            Pin_count += 1
            
            UserDefaults.standard.set(Pin_count, forKey: "Pin_count")
            
            Pin_Icon_Button.setImage(UIImage(systemName: "pin.fill"), for: .normal)
            
        }else
        {
            Pin_count -= 1
            
            UserDefaults.standard.set(Pin_count, forKey: "Pin_count")
            
            Pin_Icon_Button.setImage(UIImage(systemName: "pin"), for: .normal)
        }
        
        
    }
    
    @IBAction func Share_Button(_ sender: Any) {
        
        // create the alert
              let alert = UIAlertController(title: "Sorry", message: "UI NOT PREPARED !", preferredStyle: UIAlertController.Style.alert)

              // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil ))
        
       

              // show the alert
              self.present(alert, animated: true, completion: nil)
    }
}
