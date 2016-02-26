//
//  UIPDFView.swift
//
//
//  Created by Roman Bambura on 2/23/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//  http://www.sonettic.com
//

import UIKit 

class UIPDFView: UIView {
    
    let page = 1
    var m_resourceName:String?
    var m_resourceURL:NSURL?
    var m_resourceData:NSData?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(name: String, frame: CGRect) {
        super.init(frame: frame)
        
        m_resourceName = name + ".pdf"
        
        m_resourceURL =  PDFResourceHelper.resourceURLForName(m_resourceName!)
        
    }
    
    // Resource Name
    var resourceName:String?{
        
        set{
            m_resourceName = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return m_resourceName
        }
    }
    
    // Resource URL
    var resourceURL:NSURL?{
        
        set{
            m_resourceURL = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return m_resourceURL
        }
    }
    
    // Resource Data
    var resourceData:NSData?{
        set{
            m_resourceData = newValue;
            
            self.setNeedsDisplay()
        }
        get{
            return m_resourceData
        }
    }
    
    
    static func pageCountForURL(resourceURL: NSURL?) -> Int{
    
        var pageCount = 1;
    
        if resourceURL != nil
        {
            if let document: CGPDFDocumentRef = CGPDFDocumentCreateWithURL( resourceURL ){
        
                pageCount = CGPDFDocumentGetNumberOfPages( document );
            }
        }
    
        return pageCount;
    }

    
    func renderIntoContext(ctx: CGContextRef,  url resourceURL: NSURL?, data resourceData:NSData?, size: CGSize, page:Int, preserveAspectRatio:Bool){
        
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
            
            CGContextFillRect(ctx, destRect);
            CGContextTranslateCTM(ctx, 0.0, destRect.size.height);
            CGContextScaleCTM(ctx, 1.0, -1.0);
            CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(page1, CGPDFBox.CropBox, destRect, 0, preserveAspectRatio));
            CGContextDrawPDFPage(ctx, page1);
        }
    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect){
    
        if let ctx: CGContextRef = UIGraphicsGetCurrentContext()
        {
            self.backgroundColor?.set()
            CGContextFillRect( ctx, rect )
            layer.renderInContext(ctx)
            renderIntoContext(ctx, url:resourceURL, data:resourceData, size:rect.size, page:page, preserveAspectRatio:true)
        }
    }

}
