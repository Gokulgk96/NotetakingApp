//
//  Custom_CollectionViewCell.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 24/01/22.
//

import UIKit

class Custom_CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var Top_LAbel: UILabel!
    
    @IBOutlet weak var Pin_Button: UIButton!
    
    
    func edit(labels: String,Pin: Bool)
    {
        
        text.text = labels
        Top_LAbel.text = "Notes_Title"
        
        if(Pin)
        {
            Pin_Button.isHidden = false
            Pin_Button.isUserInteractionEnabled = false
        }else
        {
            Pin_Button.isHidden = true
        }
    }
    
    
}
