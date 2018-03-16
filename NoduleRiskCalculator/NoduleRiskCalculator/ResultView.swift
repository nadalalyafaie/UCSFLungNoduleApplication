//
//  ResultView.swift
//  NoduleRiskCalculator
//
//  Created by Nadal Alyafaie on 2/1/16.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit
import Firebase

class ResultsView: UIView {
    
    var blurView = BlurViewEffect()
    var circleView = UIView()
    var whiteSquareView = UIView()
    var blueHeaderView = UIView()
    var blueHeaderBottomHalfView = UIView()
    var resultLabel = UILabel()
    var backButton = UIButton()
    var finishedButton = UIButton()
    let finishedButtonImage = UIImage(named: "Finished Button")
    var midblueColor = UIColor(red: 86.0/255.0, green: 183.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    var leftHalfWhiteSquareView = UIView()
    var rightHalfWhiteSquareView = UIView()
    var circularProgressBar = ProgressView()
    static var riskLabel = UILabel()
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame) //frame: frame
        setUpView()
        
        //Animate the Blur View In
        animateIn()
    }
    
    func setUpView(){
        
        
        blurView = BlurViewEffect(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        self.addSubview(blurView)
        
        //Bar Graph View
        //barGraph = BarGraphView(frame: CGRect(x: self.bounds.midX, y: self.bounds.height * 0.1095, width: self.bounds.width * 0.475 , height: self.bounds.height * 0.865 ))
        //self.addSubview(barGraph)
        
        
        //Create Male Button
        circleView.frame = CGRectMake(0, 0, 100, 100)
        circleView.center.x = self.center.x
        circleView.center.y = self.bounds.height * 0.75
        circleView.transform = CGAffineTransformMakeScale(0.01, 0.01)
        circleView.backgroundColor = UIColor.clearColor()
        circleView.layer.cornerRadius = 0.5 * circleView.bounds.size.width
        circleView.layer.borderWidth = 3.0
        circleView.layer.borderColor = UIColor.whiteColor().CGColor
        circleView.alpha = 0
        self.addSubview(circleView)
        
        //constraints for finished button
        finishedButton.translatesAutoresizingMaskIntoConstraints = false
        finishedButton.centerVerticallyTo(circleView, padding: 0)
        finishedButton.centerHorizontallyTo(circleView, padding: 0)
        
        
        
        circularProgressBar = ProgressView(frame: CGRect(x: self.bounds.midX * 0.4, y: self.bounds.midY * 0.4, width: self.bounds.width * 0.6, height: self.bounds.height * 0.6))
        circularProgressBar.center.x = self.center.x
        circularProgressBar.center.y = self.center.y
        self.addSubview(circularProgressBar)
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.circularProgressBar.center.y =  self.bounds.height * 0.35
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.circleView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.circleView.alpha = 1
                    self.finishedButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.finishedButton.alpha = 1
                    ResultsView.riskLabel.alpha = 1.0
                    ResultsView.riskLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
        }
        
        
        //Finished Button
        finishedButton.frame = CGRectMake(0, 0, 100, 100)
        finishedButton.setImage(finishedButtonImage, forState: .Normal)
        finishedButton.transform = CGAffineTransformMakeScale(0.01, 0.01)
        finishedButton.alpha = 0
        finishedButton.addTarget(self, action: "finishedButtonSelected", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(finishedButton)
        //constraints for finished button
        finishedButton.translatesAutoresizingMaskIntoConstraints = false
        finishedButton.centerVerticallyTo(circleView, padding: 0)
        finishedButton.centerHorizontallyTo(circleView, padding: 0)
        
        //Risk Label
        ResultsView.riskLabel.frame = CGRectMake(0, 0, self.bounds.width, 150)
        ResultsView.riskLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
        ResultsView.riskLabel.textColor = UIColor.whiteColor()
        ResultsView.riskLabel.transform = CGAffineTransformMakeScale(0.01, 0.01)
        ResultsView.riskLabel.alpha = 0
        ResultsView.riskLabel.textAlignment = .Center
        ResultsView.riskLabel.center.y = self.bounds.height * 0.53
        ResultsView.riskLabel.center.x = self.bounds.midX
        self.addSubview(ResultsView.riskLabel)
        
        if(ViewController.calculateTotalIndex() <= 10){
            ResultsView.riskLabel.text = "Low Risk"
        } else if (ViewController.calculateTotalIndex() == 11 || ViewController.calculateTotalIndex() == 12 || ViewController.calculateTotalIndex() == 13 || ViewController.calculateTotalIndex() == 14) {
            ResultsView.riskLabel.text = "Medium Risk"
        } else if (ViewController.calculateTotalIndex() >= 15){
            ResultsView.riskLabel.text = "High Risk"
        }

        
        
        
        //Create Tap Gesture to Exit
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTapGesture")
        self.addGestureRecognizer(tap)
        
    }
    
    
    func animateIn(){
        UIView.animateWithDuration(0.25, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.whiteSquareView.alpha = 1.0
            self.whiteSquareView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.blueHeaderView.alpha = 1.0
            self.blueHeaderView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.blueHeaderBottomHalfView.alpha = 1.0
            self.blueHeaderBottomHalfView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.resultLabel.alpha = 1.0
            self.resultLabel.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.backButton.alpha = 1.0
            self.backButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            
            }) { (Bool) -> Void in
                //add code here
        }
    }
    
    func animateOut(oncompletion: () -> () = {}){
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.whiteSquareView.alpha = 0
            self.blueHeaderView.alpha = 0
            self.blueHeaderBottomHalfView.alpha = 0
            self.resultLabel.alpha = 0
            self.backButton.alpha = 0
            self.blurView.alpha = 0
            ResultsView.riskLabel.alpha = 1.0
            }) { (Bool) -> Void in
                oncompletion()
                self.removeFromSuperview()
        }
        
    }
    
    func onTapGesture(){
        animateOut()
    }
    
    
    func hide(){
        self.removeFromSuperview()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
        
    }
    
    func finishedButtonSelected(){
        print("finished button selected")
        
        //Grab title of selection option
        //print("Option selected: \((OptionSelection.options.first?.title)!)")
                
        sendToServer()
        //Grab index value of selected option
        //myRootRef.setValue("GenderIs:\((ViewController.questions.first!.selectedIndex)!)")
        
        NSNotificationCenter.defaultCenter().postNotificationName(Keys.resetIndexKey, object: nil)
        
        animateOut(){
            NSNotificationCenter.defaultCenter().postNotificationName(Keys.backToPatientIDKey, object: nil)
        }
        
        
        
        
    }
    
    func sendToServer(){
        //declare parameter as a dictionary which contains string as key and value combination.
        let doctorName : String = "\(DoctorInformationController.doctor.valueForKey("doctorname")!)"
        let doctorNumber : String = "\(DoctorInformationController.doctor.valueForKey("doctornumber")!)"
        let doctorEmail : String = "\(DoctorInformationController.doctor.valueForKey("doctoremail")!)"
        let patientId : String = "\(PatientIDViewController.patientID)"
        let gender : String = "\((ViewController.questions[0].options[(ViewController.questions[0].selectedIndex)!].title))"
        let age : String = "\((ViewController.questions[1].options[(ViewController.questions[1].selectedIndex)!].title))"
        let smokingHx : String = "\((ViewController.questions[2].options[(ViewController.questions[2].selectedIndex)!].title))"
        let occupation : String = "\((ViewController.questions[3].options[(ViewController.questions[3].selectedIndex)!].title))"
        let lungHx : String = "\((ViewController.questions[4].options[(ViewController.questions[4].selectedIndex)!].title))"
        let family : String = "\((ViewController.questions[5].options[(ViewController.questions[5].selectedIndex)!].title))"
        let lungRa : String = "\((ViewController.questions[6].options[(ViewController.questions[6].selectedIndex)!].title))"
        let border : String = "\((ViewController.questions[7].options[(ViewController.questions[7].selectedIndex)!].title))"
        let location : String = "\((ViewController.questions[8].options[(ViewController.questions[8].selectedIndex)!].title))"
        let lesion : String = "\((ViewController.questions[9].options[(ViewController.questions[9].selectedIndex)!].title))"
        let cavity : String = "\((ViewController.questions[10].options[(ViewController.questions[10].selectedIndex)!].title))"
        let size : String = "\((ViewController.questions[11].options[(ViewController.questions[11].selectedIndex)!].title))"
        let totalPoints : String = "\(ViewController.calculateTotalIndex())"
        let risk : String = "\((ResultsView.riskLabel.text)!)"
        
//        print("\(risk)")
//        print("gender is : \(gender)")
//        print("Age is : \(age)")
//        print("smoking hx is : \(smokingHx)")
//        print("occupation is : \(occupation)")
//        print("lungHx is : \(lungHx)")
//        print("family is : \(family)")
//        print("lung ra is : \(lungRa)")
//        print("border is : \(border)")
//        print("location is : \(location)")
//        print("lesion is : \(lesion)")
//        print("cavity is : \(cavity)")
//        print("size is : \(size)")
//        print("total points is : \(totalPoints)")
        
        
        let info : String = "{\"QID1\":\"\(doctorName)\",\"QID2\":\"\(doctorNumber)\",\"QID3\":\"\(doctorEmail)\",\"QID4\":\"\(patientId)\",\"QID6\":\"\(age)\",\"QID7\":\"\(gender)\",\"QID8\":\"\(smokingHx)\",\"QID9\":\"\(occupation)\",\"QID10\":\"\(lungHx)\",\"QID11\":\"\(family)\",\"QID12\":\"\(lungRa)\",\"QID13\":\"\(border)\",\"QID14\":\"\(location)\",\"QID15\":\"\(lesion)\",\"QID16\":\"\(cavity)\",\"QID17\":\"\(size)\",\"QID18\":\"\(totalPoints)\",\"QID19\":\"\(risk)\"}"

        
        
        HTTPGet("https://ucsf.co1.qualtrics.com/SE/?SID=SV_endQ3kYxKVbQllb&Q_PostResponse="+info.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!) {
            (data: String, error: String?) -> Void in
            if error != nil {
                print(error)
            } else {
                print("data is : \n\n\n")
                print(data)
            }
        }
    }
    
        
    
    func HTTPsendRequest(request: NSMutableURLRequest,callback: (String, String?) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler :
            {
                data, response, error in
                if error != nil {
                    callback("", (error!.localizedDescription) as String)
                } else {
                    callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String,nil)
                }
        })
        
        task.resume() //Tasks are called with .resume()
        
    }
    
    func HTTPGet(url: String, callback: (String, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!) //To get the URL of the receiver , var URL: NSURL? is used
        HTTPsendRequest(request, callback: callback)
    }
    
    
    
    
    
    
    
//        let post1 = ["Doctor Name": "\((DoctorInformationController.doctor.valueForKey("doctorname"))!)", "Doctor Number": "\((DoctorInformationController.doctor.valueForKey("doctornumber"))!)", "Doctor Email": "\((DoctorInformationController.doctor.valueForKey("doctoremail"))!)", "Patient ID": "\(PatientIDViewController.patientID)", "Age" : "", "Gender": "", "Smoking Hx" : "", "Occup Ag.": "", "Chronic Lung Disease Hx" : "", "Family Hx": "", "Chronic Lung Disease Radiology": "", "Nodule Border": "", "Nodule Location": "", "Sattelite Lesion": "", "Nodule Pattern Cavity": "", "Nodule Size": "", "Total Points": "", "Risk": ""]
        
        
}

