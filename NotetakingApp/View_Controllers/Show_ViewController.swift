//
//  Show_ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 25/01/22.
//

import UIKit

class Show_ViewController: UIViewController {

    @IBOutlet weak var Title_Label: UILabel!
    
    @IBOutlet weak var Desc_Label: UILabel!
    
    @IBOutlet weak var Pin_Button: UIButton!
    
    var serial_number: String = ""
    
    var Pin_Bool: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootRef.child(serial_number).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let Object = snapshot.value as! NSDictionary
            
            self.Title_Label.text = Object["title"] as! String
            
            self.Desc_Label.text = Object["description"] as! String
            
            self.Pin_Bool = Object["pinned"] as! Bool
            
            
            if(self.Pin_Bool)
            {
                self.Pin_Button.setImage(UIImage(systemName: "pin.fill"), for: .normal)
            }else{
                self.Pin_Button.setImage(UIImage(systemName: "pin"), for: .normal)
            }
            
        
    })
    
}

    func pushtoselectedviewcontroller(Serial_number: String)
    {
        guard let vc = storyboard?.instantiateViewController(identifier: "Edit_ViewController") as? Edit_ViewController
        else
        {
            return
        }
        
        vc.Serial_number = Serial_number
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Edit_Button(_ sender: Any) {
        
        pushtoselectedviewcontroller(Serial_number: serial_number)
    }
}
