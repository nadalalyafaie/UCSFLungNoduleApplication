//
//  GlobalValues.swift
//  NoduleRiskCalculator
//
//  Created by David Williames on 1/02/2016.
//  Copyright © 2016 David Williames. All rights reserved.
//

import UIKit

class Color {
    // Set the colors that are used globally, for easy reference
    static var blue = UIColor(red: 86.0/255.0, green: 183.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    static var yellow = UIColor(red: 234.0/255.0, green: 187.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static var orange = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static var pink = UIColor(red: 255.0/255.0, green: 41.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    static var red = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
}

class Keys {
    static let resetIndexKey = "resetIndex"
    static let backToPatientIDKey = "backToPatientID"
}
