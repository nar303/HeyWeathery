//
//  UIImage+Extensions.swift
//  Amore1
//
//  Created by Ashot on 27.10.22.
//

import Foundation
import UIKit

extension UIImage {
    func applyBlurFilter(val: CGFloat) -> UIImage {
        let aCIImage = CIImage(image: self)!
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(aCIImage, forKey: kCIInputImageKey)
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(clampFilter?.outputImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(val, forKey: kCIInputRadiusKey)
        
        let rect = aCIImage.extent
        if let output = blurFilter?.outputImage {
            let context = CIContext(options: nil)
            if let cgimg = context.createCGImage(output, from: rect) {
                let processedImage = UIImage(cgImage: cgimg)
                return processedImage
            }
        }
        fatalError()
    }
    
    
}
