//
//  OptionView.swift
//  NoduleRiskCalculator
//
//  Created by David Williames on 2/02/2016.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class OptionView: UIView {

    let label = UILabel() // The label shown in the center
    var index: Int = 0 // An index value used to distinguish between selections
    var option: Option
    
    // The action to call when the view is selected
    var action: (Int) -> () = {_ in }
    
    init(frame: CGRect, option: Option) {
        self.option = option
        super.init(frame: frame)
        
        // Setup the label
        label.frame = bounds
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.text = option.title // Set the text to be the option title
        label.font = UIFont(name: "Helvetica", size: 18)
        label.numberOfLines = 0 // Set to 0 means that the label will go across multiple lines if needed
        addSubview(label)
        
        // Set the border ring to be the color of the option
        layer.borderColor = option.color.CGColor
        layer.borderWidth = 3
        layer.cornerRadius = frame.width / 2
        
        // Add a long press recognizer, a long press means we can easily determine when the touch starts, moves and ends
        let tap = UILongPressGestureRecognizer(target: self, action: "tapped:")
        tap.minimumPressDuration = 0 // with no minimum duration needed. So the 'long press' acts as a normal press
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method used to animte the tap of an option nicely
    func tapped(recognizer: UIGestureRecognizer) {
        switch recognizer.state {
        case .Began: // Scale in a bit when tap begins
            UIView.animateWithDuration(0.05, animations: {
                let scale: CGFloat = 0.9
                self.transform = CGAffineTransformMakeScale(scale, scale)
                self.backgroundColor = self.option.color.colorWithAlphaComponent(0.5)
            })
        case .Changed: // If the finger moved, check if it is out of bounds of the view
            if !CGRectContainsPoint(bounds, recognizer.locationInView(self)){
                // If it is out of bounds, cancel it
                recognizer.enabled = false
                recognizer.enabled = true
            }
        case .Ended: // Scale up when selected
            UIView.animateWithDuration(0.5, animations: {
                let scale: CGFloat = 1.2
                self.transform = CGAffineTransformMakeScale(scale, scale)
                self.alpha = 0
                }, completion: { completed in
                    
            })
            // Run the selection action
            self.action(self.index)
            
        case .Cancelled: // If cancelled, reset to original scale
            UIView.animateWithDuration(0.2, animations: {
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.backgroundColor = UIColor.clearColor()
            })
        default:
            break
        }
    }

}
