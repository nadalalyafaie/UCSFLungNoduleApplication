//
//  ViewController.swift
//  NoduleRiskCalculator
//
//  Created by David Williames on 1/02/2016.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit
import Firebase

// A Struct to store a 'Question' criteria
struct Question {
    // The title of the question (Ultimately the cell title) eg. "Smoking Hx"
    var title = ""
    // An array af all the options that could be selected eg. "Never", "Past" and "Current"
    var options = [Option]()
    // Store the selected option index, once an option has been chosen
    var selectedIndex: Int? {
        // Get the saved value from NSUserDefaults
        get {
            let index = NSUserDefaults.standardUserDefaults().integerForKey("\(title) selected index")
            return index > 0 ? index - 1 : nil
        }
        // Save the value to the NSUserDefaults
        set {
            let index: Int = newValue == nil ? 0 : newValue! + 1
            NSUserDefaults.standardUserDefaults().setInteger(index, forKey: "\(title) selected index")
        }
    }

    init(_ title: String){
        self.title = title
    }
    
    init(_ title: String, options: [Option]){
        self.title = title
        self.options = options
    }
    
    // Add an option with a specific color
    mutating func addOption(title: String, color: UIColor, indexValue: Int){
        var option = Option(title, color)
        option.indexValue = indexValue
        options.append(option)
    }
    
    // Add a bunch of options by their titles, will make default color
    mutating func addOptions(titles: [String]){
        // Set the default colors, depending on how many options there are
        var colors = [Color.blue, Color.yellow, Color.orange, Color.pink, Color.red]
        if titles.count == 2 {
            colors = [Color.blue, Color.red]
        }
        else if titles.count == 3 {
            colors = [Color.blue, Color.yellow, Color.red]
        }
        
        for i in 0..<titles.count {
            // Set the option default indexValue to be its place in the array
            addOption(titles[i], color: colors[i], indexValue: i)
        }
    }
}

// A Struct to store an 'Option' as a response to a question
struct Option {
    // The text of the Option, eg. "Never"
    var title = ""
    // The color used to represent the option
    var color = UIColor.whiteColor()
    // Index value used to determine the end score
    var indexValue: Int = 0
    
    init(_ title: String, _ color: UIColor){
        self.title = title
        self.color = color
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    // An array to store all of the questions, this is the data source for the table view
    static var questions = [Question]()
    let alertController = UIAlertController(title: "Alert", message: "Enter Information In All Fields", preferredStyle: UIAlertControllerStyle.Alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        // SETUP THE QUESTIONS & THEIR OPTIONS 
        
        // Set gender questions with specific color
        var gender = Question("Gender")
        gender.addOption("Male", color: Color.blue, indexValue: 0)
        gender.addOption("Female", color: Color.pink, indexValue: 1)
        
        var age = Question("Age")
        age.addOptions(["< 50", "50 - 54", "55 - 59", "60 - 64", "65+"])
        
        // Set specific index values for spoking history
        var smoking = Question("Smoking Hx")
        smoking.addOption("Never", color: Color.blue, indexValue: 0)
        smoking.addOption("Past", color: Color.yellow, indexValue: 3)
        smoking.addOption("Current", color: Color.red, indexValue: 4)
        
        var occupation = Question("Occup. -Ag")
        occupation.addOptions(["Other", "Construct.", "Field", "Mechanic", "Military"])
        
        var lungHx = Question("Chronic Lung Disease Hx")
        lungHx.addOptions(["None", "Asthma", "Bronchitis", "COPD", "COPD & Asthma"])
        
        // Set specific index values for family history
        var family = Question("Family Hx")
        family.addOption("None", color: Color.blue, indexValue: 0)
        family.addOption("Asthma/COPD", color: Color.yellow, indexValue: 2)
        family.addOption("LungCa", color: Color.red, indexValue: 4)
        
        // Set specific index values for Chronic lung disease radiology history
        var lungRa = Question("C.L.D Radiology")
        lungRa.addOption("None/Other", color: Color.blue, indexValue: 0)
        lungRa.addOption("Reticular Changes", color: Color.red, indexValue: 4)
        
        var border = Question("Nodule Border")
        border.addOptions(["Smooth", "Lobulated", "Spiculated"])
        
        var location = Question("Nodule Location")
        location.addOptions(["RML", "LLL", "RLL", "RUL", "LUL"])
        
        var lesions = Question("Satellite Lesions")
        lesions.addOptions(["Yes", "No"])
        
        var cavity = Question("Nodule Pattern Cavity")
        cavity.addOptions(["Yes", "No"])
        
        // Set specific index values for Nodule size
        var size = Question("Nodule Size")
        size.addOption("< 2cm", color: Color.blue, indexValue: 0)
        size.addOption("> 2cm", color: Color.red, indexValue: 4)
        
        // Add all the questions to the array
        ViewController.questions = [gender, age, smoking, occupation, lungHx, family, lungRa, border, location, lesions, cavity, size]
        
        // Setup the nav bar
        navigationController?.navigationBar.barTintColor = Color.blue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barStyle = .BlackTranslucent // This will make the status bar whitena
        
        //Reset the Total Index when application closes/opens
        resetTotalIndex()
        
        //Tune in to reset Total Index
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetTotalIndex", name: Keys.resetIndexKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "backToPatientID", name: Keys.backToPatientIDKey, object: nil)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))

    }

    
    @IBAction func resultButtonSelected(sender: AnyObject) {
        
        if (ViewController.questions[0].selectedIndex == nil || ViewController.questions[1].selectedIndex == nil || ViewController.questions[2].selectedIndex == nil || ViewController.questions[3].selectedIndex == nil || ViewController.questions[4].selectedIndex == nil || ViewController.questions[5].selectedIndex == nil || ViewController.questions[6].selectedIndex == nil || ViewController.questions[7].selectedIndex == nil || ViewController.questions[8].selectedIndex == nil || ViewController.questions[9].selectedIndex == nil || ViewController.questions[10].selectedIndex == nil || ViewController.questions[11].selectedIndex == nil){
            print("A spot is empty")
            //Show Alert View
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        else {
        let resultView = ResultsView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        var currentWindow : UIWindow = UIApplication.sharedApplication().keyWindow!
        currentWindow.addSubview(resultView)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Set the cell to be a 'QuestionCell'
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! QuestionCell
        // Set the question property of the cell to be the one it needs to display
        cell.question = ViewController.questions[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect the row once it is selected. This means there will be a selection animation, but will deselect straight away
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let question = ViewController.questions[indexPath.row]
        print("\(question.title) selected")
        
        // Show the option selection view with all of the options that are related to the selected question
        let optionSelection = OptionSelection(frame: view.frame, options: question.options)
        // Set the action that will occur when an option has been selected
        optionSelection.selectedOptionAction = { index in
            ViewController.questions[indexPath.row].selectedIndex = index
            tableView.reloadData()
            // Recalculate the index
            ViewController.calculateTotalIndex()
        }
        
        // Add the option Selection view to the key window, so that it appears above the navigation bar
        UIApplication.sharedApplication().keyWindow!.addSubview(optionSelection)
    }
    
    // Calculate the total index to demonstrate example of storing index values and accessing them
    static func calculateTotalIndex()->Int {
        var totalIndex = 0
        for question in ViewController.questions {
            if let index = question.selectedIndex {
                let selectedOption = question.options[index]
                totalIndex += selectedOption.indexValue
            }
        }
        
        print("Total Index = \(totalIndex)")
        //print("The options is \()")
        return totalIndex
    }
    
    //Reset the Index If needed to
    func resetTotalIndex(){
        
        for var question in ViewController.questions{
            
            question.selectedIndex = nil
        }
        
        tableView.reloadData()
    }
    
    
    //Finished button selected(finished button is within the ResultsView Class)
    func finishedButtonSelected(){
        self.performSegueWithIdentifier("backToPatientID", sender: nil)
    }
    
    func backToPatientID(){
        print("View controller will dismiss, presenting to patient ID")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
  
    
    
}
    


