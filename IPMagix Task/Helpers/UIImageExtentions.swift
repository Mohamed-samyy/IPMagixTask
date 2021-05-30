//
//  UIImageExtentions.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/28/21.
//

import UIKit
import Kingfisher
import Foundation

extension UIImageView {
    
    func setKFImageForProfilePicture(imageUrl:String){
        if let url = URL(string:imageUrl.encodeUrl()) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url)
        }else{
            self.image = nil
        }
    }
    
    func setKFImage(imageUrl: String){
        if let url = URL(string: imageUrl) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url,placeholder: UIImage.init(named: "Image-Avatar"))
        } else { 
            self.image = nil
        }
    }
}
extension UIImage {
    func scaled(_ newSize: CGSize) -> UIImage? {
        guard size != newSize else {
            return self
        }
        
        let ratio = max(newSize.width / (size.width), newSize.height / (size.height))
        let width = size.width * ratio
        let height = size.height * ratio
        
        let scaledRect = CGRect(
            x: (newSize.width - width) / 2.0,
            y: (newSize.height - height) / 2.0,
            width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
        defer { UIGraphicsEndImageContext() }
        
        self.draw(in: scaledRect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
