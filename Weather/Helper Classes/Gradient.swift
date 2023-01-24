//
//  Gradient.swift
//  MeetApp
//
//  Created by Ashot on 16.10.22.
//

import Foundation
import UIKit

enum GradientDirection {
    case topToDown
    case leftToRight
}

class Gradient {
    
    //MARK: - New
    static func applyMainGradient(to view: UIView, direction: GradientDirection) {
        let firstColor = UIColor.red
        let secondColor = UIColor.yellow
        let colors = [firstColor.cgColor, secondColor.cgColor]
        view.setupGradient(from: colors, direction: direction)
    }
    
    //MARK: - Old
    
//    static func applyMainGradient(to view: UIView, direction: GradientDirection) {
//        let firstColor = Colors.customPink
//        let secondColor = Colors.customOrange
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupGradient(from: colors, direction: direction)
//    }
    
//    static func applyWhiteGradient(to view: UIView, direction: GradientDirection) {
//        let firstColor = UIColor.white
//        let secondColor = UIColor.white.withAlphaComponent(0.4)
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupGradient(from: colors, direction: direction)
//    }
//
//    static func applyBlueGradient(to view: UIView, direction: GradientDirection) {
//        let firstColor = UIColor.fromHex(hex: 0x0064FB)
//        let secondColor = UIColor.fromHex(hex: 0x00BDF9)
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupGradient(from: colors, direction: direction)
//    }
//
//    static func applyBlackGradient(to view: UIView, direction: GradientDirection) {
//        let firstColor: UIColor = .black.withAlphaComponent(0)
//        let secondColor: UIColor = .black
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupGradient(from: colors, direction: direction)
//    }
//
//    static func applyPurpleGradient(to view: UIView, direction: GradientDirection) {
//        let firstColor: UIColor = Colors.customFuchsia //.withAlphaComponent(22.78)
//        let secondColor: UIColor = Colors.customElectricViolet //.withAlphaComponent(90.76)
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupGradient(from: colors, direction: direction)
//    }
//
//    static func applyAngularGradient(to view: UIView, angle: CGFloat) {
//        let firstColor = UIColor.fromHex(hex: 0xFB016A).withAlphaComponent(0.1)
//        let secondColor = UIColor.fromHex(hex: 0xF95208).withAlphaComponent(0.0)
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        view.setupAngularGradient(from: colors, angle: angle)
//    }
    
    static func getMainGradientLayer(bounds: CGRect, direction: GradientDirection) -> CAGradientLayer {
        let firstColor = UIColor.red
        let secondColor = UIColor.yellow
        let colors = [firstColor.cgColor, secondColor.cgColor]
        return Gradient.getGradientLayer(bounds: bounds, colors: colors, direction: direction)
    }
    
//    static func getPurpleGradientLayer(bounds: CGRect, direction: GradientDirection) -> CAGradientLayer {
//        let firstColor: UIColor = Colors.customFuchsia
//        let secondColor: UIColor = Colors.customElectricViolet
//        let colors = [firstColor.cgColor, secondColor.cgColor]
//        return Gradient.getGradientLayer(bounds: bounds, colors: colors, direction: direction)
//    }
    
    static func getGradientLayer(bounds: CGRect, colors: [CGColor], direction: GradientDirection) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        
        switch direction {
        case .topToDown:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        return gradient
    }
    
    static func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        //create UIImage by rendering gradient layer.
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //get gradient UIcolor from gradient UIImage
        return UIColor(patternImage: image!)
    }
    
    static func convertToGrayScale(image: UIImage) -> UIImage {

        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
    }
}
