//
//  DoctorInformationController.swift
//  NoduleRiskCalculator
//
//  Created by Nadal Alyafaie on 2/11/16.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class customTextField: UITextField {
    
    let attributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Helvetica Neue", size: 22)! // Note the !
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.backgroundColor = UIColor.clearColor()
        self.textColor = UIColor.whiteColor()
        self.font = UIFont(name: self.font!.fontName, size: 22)
        self.returnKeyType = UIReturnKeyType.Done
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class lineView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class DoctorInformationController: UIViewController, UITextFieldDelegate {
    
    let doctorName = customTextField()
    let doctorNumber = customTextField()
    let doctorEmail = customTextField()
    var doctorNameLine = lineView()
    var doctorNumberLine = lineView()
    var doctorEmailLine = lineView()
    let alertController = UIAlertController(title: "Alert", message: "Enter Information In All Fields", preferredStyle: UIAlertControllerStyle.Alert)
    var doneButton = UIButton()
    var doneLabel = UILabel()
    static var doctor = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = Color.blue
        createUITextFields()
        createLines()
        createDoneButton()
        
        //This is to hide the keyboard when the user selects "done"
        self.doctorName.delegate = self
        self.doctorEmail.delegate = self
       
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If the doctor is already registered, don't worry about about asking them for their details, just go straight to the patient ID screen
        if NSUserDefaults.standardUserDefaults().boolForKey("doctorRegistered") {
            print("Doctor already registered")
            self.performSegueWithIdentifier("toPatientID", sender: nil)
        }
    }
    
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func createUITextFields(){
        //Create Doctor Name Text Field
        doctorName.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY * 0.25, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.055)
        let doctorNamePlaceholder = NSAttributedString(string: "Name", attributes: doctorName.attributes)
        doctorName.attributedPlaceholder = doctorNamePlaceholder
        self.view.addSubview(doctorName)
        
        //Create Doctor Number Text Field
        doctorNumber.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY * 0.625, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.055)
        let doctorNumberPlaceholder = NSAttributedString(string: "Number", attributes: doctorName.attributes)
        doctorNumber.attributedPlaceholder = doctorNumberPlaceholder
        doctorNumber.keyboardType = UIKeyboardType.NumberPad
        self.view.addSubview(doctorNumber)
        
        //Create Doctor Zip Text Field
        doctorEmail.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.055)
        let doctorEmailPlaceholder = NSAttributedString(string: "Email", attributes: doctorName.attributes)
        doctorEmail.attributedPlaceholder = doctorEmailPlaceholder
        doctorEmail.keyboardType = UIKeyboardType.EmailAddress
        self.view.addSubview(doctorEmail)
    }
    
    func createLines(){
        //Doctor Name Line
        doctorNameLine.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY * 0.25 + self.view.bounds.height * 0.055, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.001)
        self.view.addSubview(doctorNameLine)
        
        //Doctor Number Line
        doctorNumberLine.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY * 0.625 + self.view.bounds.height * 0.055, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.001)
        self.view.addSubview(doctorNumberLine)
        
        //Doctor Email Line
        doctorEmailLine.frame = CGRectMake(self.view.bounds.width * 0.07, self.view.bounds.midY + self.view.bounds.height * 0.055, self.view.bounds.width - self.view.bounds.width * 0.07, self.view.bounds.height * 0.001)
        self.view.addSubview(doctorEmailLine)
    }
    
    
    func createDoneButton(){
        //Done Button Created
        doneButton.frame = CGRectMake(0, (self.view.bounds.maxY - self.view.bounds.height * 0.10), self.view.bounds.width, self.view.bounds.height * 0.10)
        doneButton.backgroundColor = UIColor.whiteColor()
        doneButton.alpha = 0.9
        self.view.addSubview(doneButton)
        doneButton.addTarget(self, action: "doneButtonSelected", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Done Label over Done button
        doneLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        doneLabel.text = "Done"
        doneLabel.textColor = Color.blue
        doneLabel.frame = CGRectMake(0, 0, 100, 100)
        doneLabel.center.x = doneButton.center.x
        doneLabel.center.y = doneButton.center.y
        doneLabel.textAlignment = .Center
        self.view.addSubview(doneLabel)
    }
    
    func doneButtonSelected(){
        if (doctorName.text == "" || doctorEmail.text == "" || doctorNumber.text == ""){
            print("This shit is empty")
            
            //Show Alert View
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else{
            
            self.performSegueWithIdentifier("toPatientID", sender: nil)
            
            DoctorInformationController.doctor.setValue(doctorName.text!, forKey: "doctorname")
            DoctorInformationController.doctor.setValue(doctorEmail.text!, forKey: "doctoremail")
            DoctorInformationController.doctor.setValue(doctorNumber.text!, forKey: "doctornumber")
            DoctorInformationController.doctor.synchronize()
            print("\((DoctorInformationController.doctor.valueForKey("doctorname"))!)")
            print("\((DoctorInformationController.doctor.valueForKey("doctornumber"))!)")
            print("\((DoctorInformationController.doctor.valueForKey("doctoremail"))!)")
            
            // Mark the doctor as registered
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "doctorRegistered")
            
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //Hide Keyboard when user selects "done"
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
