//
//  CustomCheckBox.swift
//  SwiftComponentsDemo
//
//  Created by Perennial on 21/04/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit

private let CHECK_BOX_COMPONENT     = "CustomCheckBox"
private let RADIO_CHECK_IMAGE       = UIImage(named: "check_big")
private let RADIO_UNCHECK_IMAGE     = UIImage(named: "uncheck_big")
private let CHECKBOX_CHECK_IMAGE    = UIImage(named: "checkbox-ac")
private let CHECKBOX_UNCHECK_IMAGE  = UIImage(named: "checkbox-in")

var isRadioButton : Bool?

protocol CustomCheckBoxDelegate : class {
    
    func checkboxStateChanged(state: STATE, customCheckBox : CustomCheckBox)
}

class CustomCheckBox: UIView {

    @IBOutlet weak var yesNoImageView   : UIImageView!
    @IBOutlet weak var yesNoLabel       : UILabel!
    @IBOutlet weak var yesNoButton      : UIButton!    

    var checkBoxModel       : CheckBoxModel?
    weak var delegate       : CustomCheckBoxDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layoutIfNeeded()
//        if(DataManager.selectedAppLanguage() == .arabic) {
//            
//            self.reloadRTLView(self)
//        }
        setAlignment()
    }
    
    func setAlignment(){
        
   //     yesNoLabel.setAlignment()
    }
    
    class func loadViewFromXibWithFrame(frame: CGRect) -> CustomCheckBox? {

        let customCheckBox = Bundle.main.loadNibNamed(CHECK_BOX_COMPONENT, owner: self, options: nil)?.first as? CustomCheckBox
        customCheckBox!.frame = frame
        return customCheckBox
    }

    //MARK: Button Action Methods
    
    @IBAction func yesNoButtonAction(sender: UIButton) {
        
        var state = STATE.Off
        if(self.checkBoxModel!.isSelected  == false){
            
            state =  STATE.On
            
        }
        self.delegate?.checkboxStateChanged(state: state, customCheckBox: self)
    }
    
    func updateViewData(checkBoxModel : CheckBoxModel) {
        
        self.checkBoxModel = checkBoxModel
        
        //assign data to UI fields from model
        
        updateCheckboxState()
    }
    
    //MARK: Private Methods
    
    func updateCheckboxState() {
        
        if(self.checkBoxModel!.isRadioButton == true) {
            
            if self.checkBoxModel!.isSelected {
                yesNoImageView.image = RADIO_CHECK_IMAGE
            }
            else {
                yesNoImageView.image = RADIO_UNCHECK_IMAGE
            }
        }
        else {
            
            if self.checkBoxModel!.isSelected {
                
                yesNoImageView.image = CHECKBOX_CHECK_IMAGE
            }
            else {
                yesNoImageView.image = CHECKBOX_UNCHECK_IMAGE
            }
        }
    }
    
    private func changeUI() {
        
//        if DataManager.selectedAppLanguage() == .english {
//            
//            self.reloadRTLView(self)
//        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
