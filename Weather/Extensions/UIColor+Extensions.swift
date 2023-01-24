//
//  UIColor+Extensions.swift
//  MeetApp
//
//  Created by Ashot on 15.10.22.
//

import Foundation
import UIKit

extension UIColor {
    static var customPinkColor = UIColor(red: 251/255, green: 0, blue: 106/255, alpha: 1)
    static var customOrangeColor = UIColor(red: 249/255, green: 87/255, blue: 0, alpha: 1)
    static var customButtonTitleColor = UIColor(red: 71/255, green: 3/255, blue: 9/255, alpha: 0.4)
    
    static var customRadarBackground = UIColor.fromHex(hex: 0x000000).withAlphaComponent(0.7)
    static var customGreenColor = UIColor.fromHex(hex: 0x00FF85)
    static var customBoldGreenColor = UIColor.fromHex(hex: 0x70EA26)
    static var customBoldYellowColor = UIColor.fromHex(hex: 0xF69D16)
    static var customSliderBarColor = UIColor(#colorLiteral(red: 0.8939753771, green: 0.894583106, blue: 0.9013089538, alpha: 1))
    static var customLightPink = UIColor.fromHex(hex: 0xF3EBF2)
    static var customLightBlue = UIColor.fromHex(hex: 0xEBEDF3)
    static var customGoldColor = UIColor.fromHex(hex: 0xFFCF54)
    
    static func fromRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    static func fromHex(hex: Int, decodingAlpha: Bool = false) -> UIColor {
        let components = (
            alpha: CGFloat((hex >> 24) & 0xff),
            red: CGFloat((hex >> 16) & 0xff),
            green: CGFloat((hex >> 08) & 0xff),
            blue: CGFloat((hex >> 00) & 0xff)
        )
        return fromRGB(red: components.red,
                       green: components.green,
                       blue: components.blue,
                       alpha: decodingAlpha ? components.alpha : 1)
    }
    
    static func setLabelMainGradientColor(label: UILabel) {
        let layer = Gradient.getMainGradientLayer(bounds: label.frame, direction: .leftToRight)
        let color = Gradient.gradientColor(bounds: label.bounds, gradientLayer: layer)
        label.textColor = color
    }
    
//    static func setLabelPurpleGradientColor(label: UILabel) {
//        let layer = Gradient.getPurpleGradientLayer(bounds: label.frame, direction: .leftToRight)
//        let color = Gradient.gradientColor(bounds: label.bounds, gradientLayer: layer)
//        label.textColor = color
//    }
    
    static func setBorderMainGradientColor(view: UIView) {
        let layer = Gradient.getMainGradientLayer(bounds: view.frame, direction: .leftToRight)
        let color = Gradient.gradientColor(bounds: view.bounds, gradientLayer: layer)
        view.layer.borderColor = color?.cgColor
    }
}
