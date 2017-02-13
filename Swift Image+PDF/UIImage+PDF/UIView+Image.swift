//
//  UIView+Image.swift
//  WAPersonal
//
//  Created by Roman Bambura on 2/25/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//

import UIKit 

extension UIView {
    
    var imageShot: UIImage{
        
        get{
            //self.layer.shouldRasterize = true
            
            //print(self.contentScaleFactor)
            //UIGraphicsBeginImageContextWithOptions( self.bounds.size, false, self.contentScaleFactor)
            
            UIGraphicsBeginImageContextWithOptions( self.bounds.size, false, 3)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
            UIGraphicsEndImageContext();
            return image;
        }
    }
    
    
    
    func savePNG(_ filePath: String){
        if let data = UIImagePNGRepresentation(self.imageShot){
            try? data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
        }
    }
    
    
    func saveJPEG(_ filePath: String, quality:CGFloat){
        if let data = UIImageJPEGRepresentation(self.imageShot, quality){
            try? data.write(to: URL(fileURLWithPath: filePath), options: [])
        }
    }
    
}
