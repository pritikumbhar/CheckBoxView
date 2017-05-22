//
//  CheckBoxViewController.swift
//  ArabicProject
//
//  Created by Perennial on 26/04/17.
//  Copyright © 2017 perennial. All rights reserved.
//

import UIKit

enum SERACH_OPTION : Int {
    
    case AREA_SEARCH = 0
    case FACING_SEARCH
}

protocol CheckBoxViewControllerDelegate: class {
    
    func doneButtonDidSelected(_ searchOption: SERACH_OPTION)
}

class CheckBoxViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    var blurrView       : UIView!
    var delegate        : CheckBoxViewControllerDelegate?
    var checkBoxes      : [CheckBoxModel] = [CheckBoxModel]()
    var checkBoxesCopyModel : [CheckBoxModel]?
    var searchOption    : SERACH_OPTION = .AREA_SEARCH

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        addBlurrEffectToView()
        showCheckBoxes()
   //     self.reloadUI(view: btnView)
        setlocaLizeText()
    //    topView.setCorner(5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.perform(#selector(setContentSize), with: nil, afterDelay: 0.0)
    }
    
    func setlocaLizeText() {
        
//        btnDone.setTitle(localizedStringForKey(key: "DONE_TEXT", comment: ""), for: .normal)
//        btnCancel.setTitle(localizedStringForKey(key: "CANCEL_TEXT", comment: ""), for: .normal)
        
    }
    
    func getModelForId(id : String) -> CheckBoxModel?{
        
        let format = "id == %@"
        let predicate = NSPredicate(format: format,id)
        let result = checkBoxes.filter{predicate.evaluate(with: $0)}
        if((result.count) > 0) {
            
            return result.first
        }else {
            
            return nil
        }
    }
    
    //MARK:- SHow CheckBoxes
    
    func showCheckBoxes(){
        
        if((checkBoxes.count) > 0) {
            
            let checkView = CheckBoxView()
            let height = getheight()
            checkView.frame = CGRect(x: 15, y: 5, width: scrollView.frame.width - 15, height: height)
            scrollView.addSubview(checkView)
            checkView.updateUIForCheckBox(checkboxModelArray: checkBoxes)
        }
    }
    
    func getheight() -> CGFloat{
        
        var checkBoxCount  = 0
        if((checkBoxes.count) > 0) {
            checkBoxCount = checkBoxes.count
        }
        
        if(checkBoxCount % 2 != 0 ) {
            checkBoxCount = checkBoxCount + 1
        }
        checkBoxCount  = checkBoxCount/2
        return  CGFloat(checkBoxCount * 42)
    }
    
    func setContentSize(){
        
        let height = getheight()
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: height)
    }
    //MARK:- Button Action
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        for checkBox in checkBoxesCopyModel!{
            
            let model =  getModelForId(id: checkBox.id!)
            model?.isSelected = checkBox.isSelected
        }
        closeAction()
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        delegate?.doneButtonDidSelected(searchOption)
        closeAction()
    }
    
    //MARK:- BlurrView Methods
    
    func addBlurrEffectToView() {
        
        blurrView = UIView()
        blurrView.frame = self.view.frame
        self.view.addSubview(self.blurrView)
        self.view.sendSubview(toBack: self.blurrView)
        self.blurrView.alpha = 0.5
        self.blurrView.backgroundColor = UIColor.black
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(cancelButtonAction))
        self.blurrView.addGestureRecognizer(tapGesture)
    }
    
    func closeAction() {
        
        if blurrView != nil {
            
            removeBlurrEffectFromView()
        }
    }
    
    func removeBlurrEffectFromView() {
        
        if blurrView != nil {
            
            self.blurrView.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
}
