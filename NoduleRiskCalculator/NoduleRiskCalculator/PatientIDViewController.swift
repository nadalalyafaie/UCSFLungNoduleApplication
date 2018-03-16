//
//  PatientIDViewController.swift
//  NoduleRiskCalculator
//
//  Created by Nadal Alyafaie on 2/6/16.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class PatientIDViewController: UIViewController {
    
    
    let buttonSize: CGFloat = 110
    let buttonSpacing: CGFloat = 70
    var blurView = BlurViewEffect()
    var doneButton = UIButton()
    var doneLabel = UILabel()
    let backgroundimage = "Patient ID Background"
    let deleteImage = UIImage(named: "Delete Button")
    var patientIDLabel = UILabel()
    var deleteButton = UIButton()
    
    var display = UILabel()
    var userIsInTheMiddleOfTypingNumber: Bool = false
    static var patientID : String = ""
    @IBOutlet var collectionOfNumbers: [UIButton]!
    
    override func viewDidLoad() {
        
        designScreen()
        designButtons()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reset", name: Keys.backToPatientIDKey, object: nil)
    }
    
    func reset() {
        display.text = ""
        userIsInTheMiddleOfTypingNumber = false
        deleteButton.alpha = 0
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        deleteButton.alpha = 1.0
        
        if (userIsInTheMiddleOfTypingNumber){
            display.text = display.text! + digit
            
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
       PatientIDViewController.patientID = display.text!
    }
    
    
    func designButtons(){
        
        for number in collectionOfNumbers{
            let index : Int = 0
            number.tintColor = UIColor.whiteColor()
            number.translatesAutoresizingMaskIntoConstraints = false
            number.layer.borderColor = UIColor.whiteColor().CGColor
            number.layer.borderWidth = 1
            number.layer.cornerRadius = number.frame.width / 2
            number.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 38)
            
            
          
        }
        
        
        
    }
    
    
    func designScreen(){
        
        //Add Background Image
        let background = UIImage(named: backgroundimage)
        let backgroundView = UIImageView(image: background!)
        backgroundView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        backgroundView.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            backgroundView.alpha = 1.0
            }, completion: nil)
        self.view.insertSubview(backgroundView, atIndex: 0)
        
        
        //Create Blur View
        blurView = BlurViewEffect(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.insertSubview(blurView, atIndex: 1)
        
        //Patient ID Display
        display.font = UIFont(name: "Helvetica Neue", size: 25)
        display.textColor = UIColor.whiteColor()
        display.frame = CGRectMake(0, 0, self.view.bounds.width, 50)
        display.center.x = self.view.center.x
        display.center.y = self.view.center.y * 0.30
        display.textAlignment = .Center
        self.view.addSubview(display)
        
        //Patient ID Display
        patientIDLabel.text = "Enter Patient ID"
        patientIDLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        patientIDLabel.textColor = UIColor.whiteColor()
        patientIDLabel.frame = CGRectMake(0, 0, self.view.bounds.width, 50)
        patientIDLabel.center.x = self.view.center.x
        patientIDLabel.center.y = self.view.center.y * 0.20
        patientIDLabel.textAlignment = .Center
        self.view.addSubview(patientIDLabel)
        
        
        //Done Button Created
        doneButton.frame = CGRectMake(0, (self.view.bounds.maxY - self.view.bounds.height * 0.10), self.view.bounds.width, self.view.bounds.height * 0.10)
        doneButton.backgroundColor = UIColor.whiteColor()
        doneButton.alpha = 1.0
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
        
        
        //Delete Patient Id
        deleteButton.setImage(deleteImage, forState: .Normal)
        deleteButton.frame = CGRectMake(0, 0, (deleteImage?.size.width)!, (deleteImage?.size.height)!)
        deleteButton.center.x = self.view.bounds.maxX - self.view.bounds.maxX * 0.15
        deleteButton.center.y = self.view.center.y * 0.30
        deleteButton.addTarget(self, action: "deleteButtonSelected", forControlEvents: UIControlEvents.TouchUpInside)
        deleteButton.alpha = 0
        self.view.addSubview(deleteButton)
    }
    
    
    func doneButtonSelected(){
        print("Done Button Selected")
        PatientIDViewController.patientID = display.text!
        // Conditionally unwrap display.text in case it equals nil
        if let enteredID = display.text {
            PatientIDViewController.patientID = enteredID
            print("\(PatientIDViewController.patientID)")
            self.performSegueWithIdentifier("segueToViewController", sender: nil)
        }
        
    }
    
    func deleteButtonSelected(){
        print("Delete Button Selected")
        if(display.text?.characters.count > 0){
            
        let name: String = display.text!
        let stringLength = name.characters.count
        let substringIndex = stringLength - 1
        display.text = (name as NSString).substringToIndex(substringIndex)
            
        }

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

}
