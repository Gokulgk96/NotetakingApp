//
//  Setting_ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 23/01/22.
//

import UIKit

var Enable_Sharing = UserDefaults.standard



class Setting_ViewController: UIViewController {
    
    @IBOutlet weak var Enable_sharing: UISwitch!
    
    @IBOutlet weak var Add_New_Notes_Button: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let boolValue = UserDefaults.standard.bool(forKey: "mySwitch")
        
        let boolValue2 = UserDefaults.standard.bool(forKey: "mySwitch2")
        
       
            Enable_sharing.setOn(boolValue, animated: true)
            Add_New_Notes_Button.setOn(boolValue2, animated: true)
         
     
    }
    @IBAction func Add_new_note_button(_ sender: Any) {
        
        if( Add_New_Notes_Button.isOn)
        {
            UserDefaults.standard.set(true, forKey: "mySwitch2")
        }else
        {
            UserDefaults.standard.set(false, forKey: "mySwitch2")
        }
    }
    
    @IBAction func Enable_Sharing_Action(_ sender: UISwitch) {
        
        if(Enable_sharing.isOn)
        {
            UserDefaults.standard.set(true, forKey: "mySwitch")
        }else
        {
            UserDefaults.standard.set(false, forKey: "mySwitch")
        }
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
