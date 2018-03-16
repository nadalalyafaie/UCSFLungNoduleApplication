//
//  BlurViewEffect.swift
//  NoduleRiskCalculator
//
//  Created by Nadal Alyafaie on 2/1/16.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class BlurViewEffect: UIView {
    
    // MARK: PROPERTIES
    var darkBlur : UIBlurEffect?
    var darkBlurView : UIVisualEffectView?
    
    //
    
    // MARK: Initialize
    override init(frame: CGRect) {
        super.init(frame: frame) //frame: frame
        setupBlurEffect()
        
        //Animate the Blur View In
        animateIn()
    }
    
    func setupBlurEffect(){        
        self.darkBlur = UIBlurEffect(style: .Dark)
        self.darkBlurView = UIVisualEffectView(effect: self.darkBlur)
        self.darkBlurView?.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.height)
        self.alpha = 0
        self.addSubview(self.darkBlurView!)
    }
    
    
    
    func vibrancyEffectView(forBlurEffectView blurEffectView:UIVisualEffectView) -> UIVisualEffectView {
        let vibrancy = UIVibrancyEffect(forBlurEffect: blurEffectView.effect as! UIBlurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancy)
        vibrancyView.frame = blurEffectView.bounds
        vibrancyView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return vibrancyView
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
        
    }
    
    
    func animateIn(){
        UIView.animateWithDuration(0.5) { () -> Void in
            self.alpha = 0.97
        }
    }
    
    
}

