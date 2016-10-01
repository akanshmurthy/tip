//
//  UIViewExtensions.swift
//  tips
//
//  Created by Akansh Murthy on 3/20/16.
//  Copyright © 2016 Akansh Murthy. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func rotate360Degrees(_ duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as! CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
