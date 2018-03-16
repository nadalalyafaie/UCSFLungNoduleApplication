//
//  QuestionCell.swift
//  NoduleRiskCalculator
//
//  Created by David Williames on 1/02/2016.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var selectedOptionLabel: UILabel!
    @IBOutlet weak var selectedOptionIcon: UIView!
    
    // This cell will display the right information based on the question it is assigned
    var question: Question? {
        didSet {
            // Set the label to show the question title
            questionLabel.text = question?.title
            
            // If the question has a selected option index, display the options title
            if let index = question?.selectedIndex {
                let selectedOption = question!.options[index]
                selectedOptionLabel.text = selectedOption.title
                selectedOptionLabel.textColor = selectedOption.color
                selectedOptionIcon.backgroundColor = selectedOption.color
                selectedOptionLabel.hidden = false
                selectedOptionIcon.hidden = false
            }
            else {
                selectedOptionLabel.text = ""
                selectedOptionLabel.hidden = true
                selectedOptionIcon.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Setup the icon to be a circle
        selectedOptionIcon.layer.cornerRadius = selectedOptionIcon.frame.width / 2
        selectedOptionIcon.alpha = 0.5
    }

    // Override the selected and highlighted views so that the icon background color will not disappear
    override func setSelected(selected: Bool, animated: Bool) {
        let color = selectedOptionIcon.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if selected {
            selectedOptionIcon.backgroundColor = color
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        let color = selectedOptionIcon.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if highlighted {
            selectedOptionIcon.backgroundColor = color
        }
    }

}
