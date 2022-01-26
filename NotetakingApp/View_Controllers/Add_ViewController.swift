//
//  Add_ViewController.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 23/01/22.
//

import UIKit


class Add_ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
   

    @IBOutlet weak var Title_name: UITextField!
        
    @IBOutlet weak var Notes_name: UITextView!
    
    @IBOutlet weak var Add_button: UIButton!
    
    var Pin_count = 0
    
    var boolValue2: Bool = false
    
    @IBOutlet weak var Pin_Button: UIButton!
    
    var Pin_Bool = false
    
    @IBOutlet weak var Image_Views: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
       Image_Views.image = UIImage(named: "default_image")
        
        Image_Views.isUserInteractionEnabled = true

        Notes_name.text = ""
        
        boolValue2 = UserDefaults.standard.bool(forKey: "mySwitch2")
        
        Pin_count = UserDefaults.standard.integer(forKey: "Pin_count")
        
        if(Pin_count >= 4)
        {
            Pin_Button.isHidden = true
        }else
        {
            Pin_Button.isHidden = false
        }
        
        
    }
    
    @IBAction func Tap_gesture_on_image(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
        return
    }
        guard let imageData = image.pngData() else
        {
            return
        }
        Image_Views.image = UIImage(data: imageData)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Pin_Button_Action(_ sender: Any) {
        
            Pin_Bool = !Pin_Bool
            
            if(Pin_Bool)
            {
                Pin_count += 1
                UserDefaults.standard.set(Pin_count, forKey: "Pin_count")
                Pin_Button.setImage(UIImage(systemName: "pin.fill"), for: .normal)
                
            }else
            {
                Pin_count -= 1
                UserDefaults.standard.set(Pin_count, forKey: "Pin_count")
                Pin_Button.setImage(UIImage(systemName: "pin"), for: .normal)
            }
        
    }
    
    
    @IBAction func Add_Button(_ sender: Any) {
      
        if(Title_name.text?.count == 0 || Notes_name.text?.count == 0 )
        {
            // create the alert
                  let alert = UIAlertController(title: "Error", message: "Dont Leave any empty Field.", preferredStyle: UIAlertController.Style.alert)

                  // add an action (button)
                  alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                  // show the alert
                  self.present(alert, animated: true, completion: nil)
            
        }else
        {
        
            let key = rootRef.childByAutoId().key
            
            let insert_value = ["title": Title_name.text! ,"description": Notes_name.text!, "pinned": Pin_Bool, "Serial_number" : key! ,"on_Top": boolValue2 ] as [String : Any]
         
            
        
            rootRef.child(key!).setValue(insert_value)
    
            
            // create the alert
                  let alert = UIAlertController(title: "Success", message: "Added Successfully", preferredStyle: UIAlertController.Style.alert)

                  // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                
                self.navigationController?.popViewController(animated: true)
                
            }))

                  // show the alert
                  self.present(alert, animated: true, completion: nil)
         
        }
      
    }
   
    
   
}


