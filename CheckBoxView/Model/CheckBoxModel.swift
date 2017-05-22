//
//  CheckBoxModel.swift
//  SwiftComponentsDemo
//
//  Created by Perennial on 21/04/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit

class CheckBoxModel: NSObject {
    
    var id                      : String?
    var isSelected              : Bool = false
    var isRadioButton           : Bool = false
    var multiplicationFactor    : String?
    var value                   : String? = ""
    
    var selected             : String? {
        
        didSet {
            if(selected == "1") {
                
                isSelected = true
            }
        }
    }

}
