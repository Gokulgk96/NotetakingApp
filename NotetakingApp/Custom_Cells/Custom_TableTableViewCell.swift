//
//  Custom_TableTableViewCell.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 26/01/22.
//

import UIKit

class Custom_TableTableViewCell: UITableViewCell {

    @IBOutlet weak var Main_Label: UILabel!
    
    func set(Label: String)
    {
        Main_Label.text = Label
    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
