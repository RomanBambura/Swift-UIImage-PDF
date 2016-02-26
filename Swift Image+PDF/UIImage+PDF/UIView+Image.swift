//
//  UIView+Image.swift
//  WAPersonal
//
//  Created by Roman Bambura on 2/25/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//

import UIKit 

extension UIView {
    
    var image: UIImage{
        
        get{
            self.layer.shouldRasterize = true
        
            UIGraphicsBeginImageContextWithOptions( self.bounds.size, false, self.contentScaleFactor )
            self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
    }
    
    
    
    func savePNG(filePath: String){
        if let data = UIImagePNGRepresentation(self.image){
            data.writeToFile(filePath, atomically:true)
        }
    }
    
    
    func saveJPEG(filePath: String, quality:CGFloat){
        if let data = UIImageJPEGRepresentation(self.image, quality){
            data.writeToFile(filePath, atomically:false)
        }
    }
    
}