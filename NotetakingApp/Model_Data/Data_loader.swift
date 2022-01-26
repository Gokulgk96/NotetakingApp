//
//  Data_loader.swift
//  NotetakingApp
//
//  Created by Gokul Gopalakrishnan on 24/01/22.
//

import Foundation


var UnPinned_datas = [Caller]()

var Pinned_datas = [Caller]()

var Total_datas = [Caller]()

var Deleting_datas = [Del_Caller]()


struct Caller {
    var title: String?
    var desc: String?
    var pinned: Bool
    var serial_number: String
    var on_Top: Bool
    
    
    init(title: String, desc: String, pinned: Bool, serial_number: String, on_Top: Bool)
    {
        self.title = title
        self.desc = desc
        self.pinned = pinned
        self.serial_number = serial_number
        self.on_Top = on_Top
    }
}



struct Del_Caller {
    var title: String?
 
    var serial_number: String
   
    
    
    init(title: String, serial_number: String)
    {
        self.title = title
        self.serial_number = serial_number
        
    }
}

