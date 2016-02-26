//
//  PDFResourceHelper.swift
//  WAPersonal
//
//  Created by Roman Bambura on 2/25/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//

import UIKit

class PDFResourceHelper {
     
    static func resourceURLForName(resourceName:String?) -> NSURL?{
        
        if let path = NSBundle.mainBundle().pathForResource(resourceName , ofType: nil){
            return NSURL(fileURLWithPath:path)
        }
        return nil
    }
    
    static func mediaRect(resourceName: String?) -> CGRect
    {
        return self.mediaRectForURL(self.resourceURLForName(resourceName)!)
    }
    
    static func mediaRectForURL(resourceURL: NSURL) -> CGRect
    {
        return mediaRectForURL(resourceURL, page:1)
    }
    
    
    
    
    static func mediaRectForURL(resourceURL: NSURL?,  page: Int)-> CGRect{
        
        var rect:CGRect = CGRectNull
        
        if resourceURL != nil
        {
            if let pdf:CGPDFDocumentRef? = CGPDFDocumentCreateWithURL(resourceURL)
            {
                
                if let page1:CGPDFPageRef = CGPDFDocumentGetPage( pdf, page)
                {
                    
                    rect = CGPDFPageGetBoxRect(page1, CGPDFBox.CropBox)
                    
                    let rotationAngle = CGPDFPageGetRotationAngle(page1)
                    
                    if (rotationAngle == 90 || rotationAngle == 270)
                    {
                        let temp = rect.size.width
                        rect.size.width = rect.size.height
                        rect.size.height = temp
                    }
                }
            }
        }
        
        return rect;
    }
    
    static func renderIntoContext(ctx: CGContextRef,  url resourceURL: NSURL?, data resourceData:NSData?, size: CGSize, page:Int, preserveAspectRatio:Bool){
        
        var document: CGPDFDocumentRef?
        
        if resourceURL != nil
        {
            document = CGPDFDocumentCreateWithURL( resourceURL )!
        }
        else if resourceData != nil
        {
            if let provider: CGDataProviderRef = CGDataProviderCreateWithCFData( resourceData )
            {
                document = CGPDFDocumentCreateWithProvider( provider )!
            }
        }
        
        if let page1: CGPDFPageRef = CGPDFDocumentGetPage( document, page ){
            
            let destRect: CGRect = CGRectMake(0, 0, size.width, size.height)
            
            let drawingTransform: CGAffineTransform = CGPDFPageGetDrawingTransform(page1, CGPDFBox.CropBox, destRect, 0, preserveAspectRatio);
            CGContextConcatCTM(ctx, drawingTransform)
            CGContextDrawPDFPage( ctx, page1 )
        }
    }

    static func mediaRectForData(data: NSData?,  page: Int) -> CGRect{
        
        var rect:CGRect = CGRectNull
        
        if data != nil
        {
            if let provider:CGDataProviderRef = CGDataProviderCreateWithCFData( data )
            {
                
                if let document:CGPDFDocumentRef = CGPDFDocumentCreateWithProvider( provider ){
                    
                    if let page1:CGPDFPageRef = CGPDFDocumentGetPage( document, page )
                    {
                        
                        rect = CGPDFPageGetBoxRect( page1, CGPDFBox.CropBox )
                        
                        let rotationAngle = CGPDFPageGetRotationAngle( page1 )
                        
                        if (rotationAngle == 90 || rotationAngle == 270)
                        {
                            let temp = rect.size.width
                            rect.size.width = rect.size.height
                            rect.size.height = temp
                        }
                    }
                }
            }
        }
        
        return rect;
    }


}