//
//  UIViewController+Extensions.swift
//  LogoHere
//
//  Created by Ashot on 19.01.23.
//

import UIKit

extension UIViewController {
    
    func addChild(_ vc: UIViewController, toView view: UIView, clipsToBounds: Bool = false) {
        self.addChild(vc)
        view.addSubview(vc.view)
        if !clipsToBounds {
            vc.view.frame = view.bounds
        } else {
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            for attribute in [NSLayoutConstraint.Attribute.top, .bottom, .leading, .trailing] {
                let constraint = NSLayoutConstraint(item: vc.view!, attribute: attribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: attribute, multiplier: 1, constant: 0)
                view.addConstraint(constraint)
            }
        }
        /*vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.view.translatesAutoresizingMaskIntoConstraints = true
        if clipsToBounds {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
                print(vc.view.frame, vc.view.constraints, vc.view.superview?.frame)
            }
        }*/
    }
    
}
