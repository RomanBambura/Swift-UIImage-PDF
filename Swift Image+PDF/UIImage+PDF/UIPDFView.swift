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
    var m_resourceURL:URL?
    var m_resourceData:Data?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(withName name: String, frame: CGRect) {
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
    var resourceURL:URL?{
        
        set{
            m_resourceURL = newValue
            
            self.setNeedsDisplay()
        }
        get{
            return m_resourceURL
        }
    }
    
    // Resource Data
    var resourceData:Data?{
        set{
            m_resourceData = newValue;
            
            self.setNeedsDisplay()
        }
        get{
            return m_resourceData
        }
    }
    
    
    static func pageCountForURL(_ resourceURL: URL?) -> Int{
    
        var pageCount = 1;
    
        if resourceURL != nil
        {
            if let document: CGPDFDocument = CGPDFDocument( resourceURL as! CFURL){
        
                pageCount = document.numberOfPages;
            }
        }
    
        return pageCount;
    }

    
    func renderIntoContext(_ ctx: CGContext,  url resourceURL: URL?, data resourceData:Data?, size: CGSize, page:Int, preserveAspectRatio:Bool){
        
        var document: CGPDFDocument?

        if resourceURL != nil
        {
            document = CGPDFDocument( resourceURL as! CFURL )!
        }
        else if resourceData != nil
        {
            if let provider: CGDataProvider = CGDataProvider( data: resourceData as! CFData )
            {
                document = CGPDFDocument( provider )!
            }
        }
        
        if let page1: CGPDFPage = document?.page(at: page ){
        
            let destRect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            ctx.fill(destRect);
            ctx.translateBy(x: 0.0, y: destRect.size.height);
            ctx.scaleBy(x: 1.0, y: -1.0);
            ctx.concatenate(page1.getDrawingTransform(CGPDFBox.cropBox, rect: destRect, rotate: 0, preserveAspectRatio: preserveAspectRatio));
            ctx.drawPDFPage(page1);
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect){
     
        if let ctx: CGContext = UIGraphicsGetCurrentContext()
        {
            self.backgroundColor?.set()
            ctx.fill(rect )
            layer.render(in: ctx)
            renderIntoContext(ctx, url:resourceURL, data:resourceData, size:rect.size, page:page, preserveAspectRatio:true)
        }
    }

}
