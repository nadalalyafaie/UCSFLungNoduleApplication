//
//  OptionSelection.swift
//  NoduleRiskCalculator
//
//  Created by David Williames on 1/02/2016.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class OptionSelection: UIView {
    
    // Constant values to define the Option view circle sizing and spacing
    let optionViewSize: CGFloat = 110
    let optionViewSpacing: CGFloat = 70
    
    
    // Store the option values
    static var options = [Option]()
    // The Option views (circles)
    var optionViews = [OptionView]()
    // A container to hold all of the option views, in order to center it in the screen
    let optionViewContainer = UIView()
    
    // The action to be called back when an option is selected
    var selectedOptionAction: (Int) -> () = { _ in }
    
    
    
    init(frame: CGRect, options: [Option]) {
        OptionSelection.options = options
        super.init(frame: frame)

        // Add a blur to the background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = bounds
        addSubview(visualEffectView)
        
        // Setup the views, then animate them appearing
        setUpOptionViews()
        animateViewsOn()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onTapGesture")
        self.addGestureRecognizer(tap)
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This could probaly be done better
    func setUpOptionViews() {
        let rows: CGFloat = ceil(CGFloat(OptionSelection.options.count) / 2)
        optionViewContainer.frame = CGRectMake(0, 0, optionViewSize*2 + optionViewSpacing, rows*optionViewSize + (rows - 1)*optionViewSpacing)
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var index: Int = 0
        
        // Cycle through the options, create an OptionView for each, and lay it out in a grid
        for option in OptionSelection.options {
            let optionView = OptionView(frame: CGRectMake(x, y, optionViewSize, optionViewSize), option: option)
            optionView.index = index
            optionView.action = { i in
                self.optionSelected(i)
            }
            optionViewContainer.addSubview(optionView)
            optionViews.append(optionView)
            
            index++
            
            if index % 2 == 0 && index == OptionSelection.options.count - 1 {
                x = (optionViewSize + optionViewSpacing) / 2
                y += optionViewSize + optionViewSpacing
            }
            else if index % 2 == 0 {
                x = 0
                y += optionViewSize + optionViewSpacing
            }
            else if index % 2 == 1 {
                x = optionViewSize + optionViewSpacing
            }
        }
        
        addSubview(optionViewContainer)
        optionViewContainer.center = center
    }
    
    func animateViewsOn() {
        alpha = 0
        
        // Animate the transparency on
        var delay: NSTimeInterval = 0.3
        UIView.animateWithDuration(delay, animations: {
            self.alpha = 1
            })
        
        // Cycle through the optionViews and animate them one in sequence
        for view in optionViews {
            view.alpha = 0
            view.transform = CGAffineTransformMakeScale(0.5, 0.5)
            
            UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .CurveLinear, animations: {
                view.alpha = 1
                view.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
            delay += 0.1
        }
        
        
    }
    
    // When the option is selected, run the selection animation and fade out
    func optionSelected(index: Int) {
        print("Selected option: \(OptionSelection.options[index].title)")
        selectedOptionAction(index)
        
        onTapGesture()
    }
    
    func onTapGesture(){
        
        UIView.animateWithDuration(0.3, animations: {
            self.alpha = 0
            }, completion: { completed in
                // Once fade is finished remove from the window so that it is deallocated from memory
                self.removeFromSuperview()
        })
    }

}
