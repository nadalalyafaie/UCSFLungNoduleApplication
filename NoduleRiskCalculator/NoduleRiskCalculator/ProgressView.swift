//
//  ProgressView.swift
//  NoduleRiskCalculator
//
//  Created by Nadal Alyafaie on 2/1/16.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    let totalPoints = ViewController.calculateTotalIndex()
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    private var progressLabel: UILabel
    
    
    required init?(coder aDecoder: NSCoder) {
        progressLabel = UILabel()
        super.init(coder: aDecoder)
        createProgressLayer()
        createLabel()
    }
    
    override init(frame: CGRect) {
        progressLabel = UILabel()
        super.init(frame: frame)
        
        createProgressLayer()
        createLabel()
        animateProgressView()
    }
    
    func createLabel() {
        progressLabel = UILabel(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(frame), 60.0))
        progressLabel.textColor = .whiteColor()
        progressLabel.textAlignment = .Center
        progressLabel.alpha = 0
        progressLabel.text = "\(totalPoints)"
        progressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 60.0)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: progressLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    private func createProgressLayer() {
        let startAngle = CGFloat(M_PI_2)
        let endAngle = CGFloat(M_PI * 2 + M_PI_2)
        let centerPoint = CGPointMake(CGRectGetWidth(frame)/2 , CGRectGetHeight(frame)/2)
        
        let gradientMaskLayer = gradientMask()
        progressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: CGRectGetWidth(frame)/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        progressLayer.lineWidth = 6.5
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = progressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    private func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.0, 1.0]
        
        let blueTop: AnyObject = UIColor(red: 86.0/255.0, green: 183.0/255.0, blue: 241.0/255.0, alpha: 1.0).CGColor
        let blueBottom: AnyObject = UIColor(red: 81.0/255.0, green: 237.0/255.0, blue: 198.0/255.0, alpha: 1.0).CGColor
        let blueArrayOfColors: [AnyObject] = [blueTop, blueBottom]
        
        let yellowBottom: AnyObject = UIColor(red: 234.0/255.0, green: 187.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        let yellowTop: AnyObject = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        let yellowArrayOfColors: [AnyObject] = [yellowTop, yellowBottom]
        
        let redTop: AnyObject = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0).CGColor
        let redBottom: AnyObject = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        let redArrayOfColors: [AnyObject] = [redTop, redBottom]
        
        if(totalPoints <= 10){
            gradientLayer.colors = blueArrayOfColors
        }
        
        else if (totalPoints == 11 || totalPoints == 12 || totalPoints == 13 || totalPoints == 14) {
            gradientLayer.colors = yellowArrayOfColors
        }
        
        else if (totalPoints >= 15){
            
            gradientLayer.colors = redArrayOfColors
            
        }
        return gradientLayer
    }
    
    func hideProgressView() {
        progressLayer.strokeEnd = 0.0
        progressLayer.removeAllAnimations()
    }
    
    func animateProgressView() {
        progressLayer.strokeEnd = 0.0
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 2.0
        animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = true
        animation.fillMode = kCAFillModeForwards
        progressLayer.addAnimation(animation, forKey: "strokeEnd")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.progressLabel.alpha = 1.0
        }
        
    }
    
    
    
}


