//
//  UIView+Extensions.swift
//  MeetApp
//
//  Created by Ashot on 15.10.22.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadiusInspec: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var viewBorderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var viewBorderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    func setupGradient(from colors: [CGColor], direction: GradientDirection) {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.frame = CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.colors = colors
        
        switch direction {
        case .topToDown:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupAngularGradient(from colors: [CGColor], angle: CGFloat) {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.type = .radial
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = colors
    
        
        gradientLayer.calculatePoints(for: angle)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.clipsToBounds = false
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor,
                      left: superview?.leftAnchor,
                      bottom: superview?.bottomAnchor,
                      right: superview?.rightAnchor)
    }
    
    
}

//MARK: - Bluring -
protocol Blurable {
    func addBlur(_ alpha: CGFloat, style: UIBlurEffect.Style)
}

extension Blurable where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5, style: UIBlurEffect.Style = .light) {
        let effect = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }
}

// Conformance
extension UIView: Blurable {}

//MARK: -


extension UIView {
    func addShadowColor(color1: UIColor, color2: UIColor, color3: UIColor) {
        let shadowLayer = CALayer.init()
        shadowLayer.frame = self.bounds
        shadowLayer.shadowColor = UIColor(red: 118 / 255, green: 209 / 255, blue: 203 / 255, alpha: 0.67).cgColor
        shadowLayer.shadowOpacity = 0.67
        shadowLayer.shadowRadius = 16
        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addShadowColor(color: UIColor) {
        let shadowLayer = CALayer.init()
        shadowLayer.frame = self.bounds
        shadowLayer.shadowColor = color.cgColor //UIColor(red: 118 / 255, green: 209 / 255, blue: 203 / 255, alpha: 0.67).cgColor
        shadowLayer.shadowOpacity = 0.67
        shadowLayer.shadowOffset = CGSize(width: 2, height: 3)
        shadowLayer.shadowPath = CGPath.init(rect: shadowLayer.bounds, transform: nil)
        self.layer.insertSublayer(shadowLayer, at: 0)
        shadowLayer.shadowRadius = 16
    }
    
    

    func addGradientWithColor(colorFirst: UIColor, colorSecond: UIColor?, radius: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        if let colorSecond = colorSecond {
            gradient.colors = [colorFirst.cgColor, colorSecond.cgColor]
        } else {
            gradient.colors = [colorFirst.cgColor]
        }
        gradient.cornerRadius = radius
        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = false
        self.layer.cornerRadius = radius
    }
    
    func addGradientShadowViewColorV(colorFirst: UIColor, colorSecond: UIColor?, radius: CGFloat, opacity: Float) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.shadowOpacity = 0.5
//        gradient.opacity = 0.3
        if let colorSecond = colorSecond {
            gradient.colors = [colorFirst.cgColor, colorSecond.cgColor]
        } else {
            gradient.colors = [colorFirst.cgColor]
        }
        gradient.cornerRadius = radius
        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = false
        self.layer.cornerRadius = radius
    }

    func addGradientShadowViewColor(colorFirst: UIColor, colorSecond: UIColor?, radius: CGFloat, opacity: Float) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.shadowOpacity = opacity
        gradient.opacity = 0.3
        if let colorSecond = colorSecond {
            gradient.colors = [colorFirst.cgColor, colorSecond.cgColor]
        } else {
            gradient.colors = [colorFirst.cgColor]
        }
        gradient.cornerRadius = radius
        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = false
        self.layer.cornerRadius = radius
    }
    
    func addSubViewWithLayouts(view: UIView?) {
        guard let view = view else {return}
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addShadow(color: CGColor, opacity: Float, radius: CGFloat, offset: CGSize) {
//        layer.shadowColor = CGColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
//        layer.shadowOpacity = 0.1
//        layer.shadowRadius = 4
//        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    func layoutGradients() {
        self.layer.sublayers?.forEach({ layer in
            if layer is CAGradientLayer {
                layer.frame = self.bounds
            }
        })
    }

}
