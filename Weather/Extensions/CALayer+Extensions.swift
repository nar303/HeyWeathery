//
//  CALayer.swift
//  LogoHere
//
//  Created by Ashot on 18.01.23.
//

import Foundation
import UIKit

extension CALayer {
    public func setShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        shadowColor = color.cgColor
        self.opacity = opacity
        shadowOffset = offset
        shadowRadius = radius
        cornerRadius = 10.0
        shadowOpacity = 1
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
}
