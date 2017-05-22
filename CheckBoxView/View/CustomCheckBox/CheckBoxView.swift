//
//  CheckBoxView.swift
//  SwiftComponentsDemo
//
//  Created by Perennial on 21/04/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit

let CHECK_BOX_HEIGHT        : CGFloat  =   30
let CHECK_BOX_BOTTOM_SPACE  : CGFloat  =   10
let SCREEN_WIDTH            = UIScreen.main.bounds.size.width

enum STATE {
    case On
    case Off
}

protocol CheckBoxViewDelegate : class {
    
    func checkBoxStateChangedFor(checkBoxModelarray: [CheckBoxModel])
}

class CheckBoxView: UIView, CustomCheckBoxDelegate {
    
    var checkBoxModelarray      = [CheckBoxModel]()
    var checkBoxes              = [CustomCheckBox]()
    weak var delegate           : CheckBoxViewDelegate? = nil
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layoutIfNeeded()
    }
    
    func updateUIForCheckBox(checkboxModelArray : [CheckBoxModel]) {
        
        checkBoxes.removeAll()
        
        checkBoxModelarray = checkboxModelArray
        var yPoint : CGFloat = 5.0
        let width : CGFloat = CGFloat(SCREEN_WIDTH - 90)/2 - 20
        var xPoint : CGFloat = 0.0
//        if(DataManager.selectedAppLanguage() == .arabic) {
//            
//            xPoint =  width + 42.0
//        }
        
        for index in 0..<checkboxModelArray.count {
            
            let checkBoxesView = CustomCheckBox.loadViewFromXibWithFrame(frame: CGRect(x: xPoint, y: yPoint, width: width, height: CHECK_BOX_HEIGHT))
            checkBoxesView?.updateViewData(checkBoxModel: checkboxModelArray[index])
            checkBoxesView?.delegate = self
            checkBoxes.append(checkBoxesView!)
            self.addSubview(checkBoxesView!)
            
            if(index%2 == 0) {
                
               // xPoint = DataManager.selectedAppLanguage() == .arabic ? 0 : width + 42
                xPoint = 0
            } else {
                
               // xPoint = DataManager.selectedAppLanguage() == .arabic ? width + 42 : 0
                xPoint = width + 42
                yPoint += CHECK_BOX_HEIGHT + 10
            }
        }
    }
    
    func updateUI(checkboxModelArray : [CheckBoxModel]) {
        
        removePreviousViews()
        checkBoxes.removeAll()
        
        checkBoxModelarray = checkboxModelArray
        var yPoint : CGFloat = 5.0
        let width : CGFloat = CGFloat(SCREEN_WIDTH - 60)/2 - 20
        var xPoint : CGFloat = 0.0
//        if(DataManager.selectedAppLanguage() == .arabic) {
//            xPoint =  width + 40.0
//        }
        
        for index in 0..<checkboxModelArray.count {
            
            let checkBoxesView = CustomCheckBox.loadViewFromXibWithFrame(frame: CGRect(x: xPoint, y: yPoint, width: width, height: CHECK_BOX_HEIGHT))
            checkBoxesView?.updateViewData(checkBoxModel: checkboxModelArray[index])
            checkBoxesView?.delegate = self
            checkBoxes.append(checkBoxesView!)
            self.addSubview(checkBoxesView!)
            
            if(index%2 == 0) {
                
             //   xPoint = DataManager.selectedAppLanguage() == .arabic ? 0 : width + 40
                xPoint = 0
            } else {
                
             //   xPoint = DataManager.selectedAppLanguage() == .arabic ? width + 40 : 0
                xPoint = width + 40
                yPoint += CHECK_BOX_HEIGHT + 10
            }
        }
    }
    
    //MARK:- CheckboxComponentDelegate Method
    
    func checkboxStateChanged(state: STATE, customCheckBox checkBoxComponent : CustomCheckBox) {
        
        if(checkBoxComponent.checkBoxModel?.isRadioButton == true) {
            
            (checkBoxModelarray as NSArray).setValue(false, forKey: "isSelected")
        }
        if state == STATE.On {
            
            checkBoxComponent.checkBoxModel!.isSelected = true
        }else {
            
            checkBoxComponent.checkBoxModel!.isSelected = false
        }
        delegate?.checkBoxStateChangedFor(checkBoxModelarray: self.checkBoxModelarray)
        updateUIForRadioButton()
    }
    
    private func updateUIForRadioButton() {
        
        for checkboxView in checkBoxes {
            
            checkboxView.updateCheckboxState()
        }
    }
    
    private func removePreviousViews(){
        
        for checkboxView in self.subviews {
            
            checkboxView.removeFromSuperview()
        }
    }
    
}

