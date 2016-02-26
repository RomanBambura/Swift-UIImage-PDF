//
//  UIImage+PDF.swift
//
//  Created by Roman Bambura on 2/23/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//  http://www.sonettic.com
//
 
import UIKit

extension UIImage {
    
    // MARK:  Control cache
    private static var _imagesCache: NSCache?
    private static var _shouldCache: Bool = false
    private static var _shouldCacheOnDisk: Bool = true
    private static var _assetName: String?
    private static var _resourceName: String?
    
    
    static var cachedAssetsDirectory: String{
        get{
            return "CachedAssets"
        }
    }
    
    static var resourceName: String?{
        
        set{
            _resourceName = newValue
            _assetName = newValue!.componentsSeparatedByString(".")[0]
        }
        get{
            return _resourceName
        }
    }
    
    static var assetName: String? {
        set{
            _assetName = newValue
            _resourceName = _assetName! + ".pdf"
        }
        get{
            return _assetName
        }
    }
    
    
    static var shouldCacheInMemory:Bool{
        
        set{
            _shouldCache = newValue
    
            if( _shouldCache && _imagesCache == nil)
            {
                _imagesCache = NSCache()
            }
        }
        get{
            return _shouldCache
        }
    }
    
    static var shouldCacheOnDisk: Bool {
    
        set{
            _shouldCacheOnDisk = newValue;
        }
        get{
            return _shouldCacheOnDisk
        }
        
    }
    

    // Mark: Public Func
    
    // Mark: Convenience methods
    class func pdfAssetNamed(name: String) -> UIImage?{
        
        assetName = name
        
        return self.originalSizeImageWithPDFNamed(resourceName!)
    }
    
    class func pdfAssetWithContentsOfFile(path: String) -> UIImage?{
        return self.originalSizeImageWithPDFURL( NSURL.fileURLWithPath(path))
    }
    
    class func screenScale() -> CGFloat{
        return UIScreen.mainScreen().scale
    }
    
    
    // Mark: Get UIImage With PDF Name Without Extension
    
    // Mark: UIImage With Size
    class func imageWithPDFNamed(name: String, size:CGSize) -> UIImage? {
        
        assetName = name
        
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName)!, size:size)
    }
    
    // Mark:  UIImage With Width
    class func imageWithPDFNamed(name: String,  width:CGFloat) -> UIImage?{
        
        assetName = name
        
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName), width: width)
    }
    
    // Mark:  UIImage With Height
    class func imageWithPDFNamed(name: String,  height:CGFloat) -> UIImage?{
        
        assetName = name
        
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName), height: height)
    }
    
    // Mark:  UIImage  Size To Fit
    class func imageWithPDFNamed(name: String, fitSize size: CGSize) -> UIImage? {
        
        assetName = name
        
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(_resourceName), fitSize:size)
    }
    
    
    
    // Mark: Resource name
    // Size
    private class func imageWithPDFNamed(name: String, size: CGSize,  page: Int) -> UIImage? {
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName!), size:size, page:page)
    }
    
    // Width
    private class func imageWithPDFNamed(name: String,  width:CGFloat,  page: Int) -> UIImage?{
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName), width: width, page: page)
    }
    
    // Height
    private class func imageWithPDFNamed( name: String,  height:CGFloat,  page: Int) -> UIImage?{
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(resourceName), height : height, page: page)
    }

    // Fit
    private class func imageWithPDFNamed(name: String, fitSize size: CGSize,  page: Int) -> UIImage? {
        return self.imageWithPDFURL( PDFResourceHelper.resourceURLForName(name), fitSize:size, page:page)
    }
    
    // Original Size
    private class func originalSizeImageWithPDFNamed(resourceName: String,  page: Int) -> UIImage?{
        return self.originalSizeImageWithPDFURL( PDFResourceHelper.resourceURLForName( resourceName ), page:page)
    }
    
    private class func originalSizeImageWithPDFNamed(resourceName: String) -> UIImage?{
        return self.originalSizeImageWithPDFURL( PDFResourceHelper.resourceURLForName( resourceName) )
    }


    // Mark: Resource Data
    class func originalSizeImageWithPDFData( data: NSData ) -> UIImage? {
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForData(data, page:1)
        return self.imageWithPDFData(data, size:mediaRect.size, page:1 )
    }
    
    class func imageWithPDFData(data: NSData,  width:CGFloat) -> UIImage?{
        return self.imageWithPDFData(data, width:width, page:1)
    }
    
    class func imageWithPDFData(data: NSData?,  width:CGFloat,  page:Int) -> UIImage?{
    
        if ( data == nil ){
          return UIImage()
        }
        
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForData(data, page:page)
        let aspectRatio: CGFloat = mediaRect.size.width / mediaRect.size.height
        let size: CGSize = CGSizeMake( width, ceil( width / aspectRatio ))
        
        return self.imageWithPDFData(data, size:size, page:page)
    }
    

    class func imageWithPDFData(data: NSData?,  height:CGFloat) -> UIImage? {
        return self.imageWithPDFData(data, height:height, page:1)
    }

    class func imageWithPDFData(data: NSData?,  height:CGFloat,  page:Int) -> UIImage?{
        
        if ( data == nil ){
            return UIImage()
        }
        
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForData(data, page:page)
        let aspectRatio: CGFloat = mediaRect.size.width / mediaRect.size.height
        let size: CGSize = CGSizeMake( ceil( height / aspectRatio ), height)
        
        return self.imageWithPDFData(data, size:size, page:page)
    }
    
    class func imageWithPDFData( data: NSData?, fitSize size:CGSize) -> UIImage? {
        return self.imageWithPDFData(data, fitSize:size, page:1)
    }
    
    class func imageWithPDFData(data: NSData?, fitSize size: CGSize,  page: Int) -> UIImage? {
        return self.imageWithPDFData(data, size:size, page:page, preserveAspectRatio:true)
    }
    
    class func imageWithPDFData(data: NSData?,  size: CGSize ) -> UIImage? {
        return self.imageWithPDFData(data, size:size, page:1)
    }
    
    class func imageWithPDFData( data: NSData?,  size: CGSize,  page: Int) -> UIImage? {
        return self.imageWithPDFData(data, size:size, page:page, preserveAspectRatio:false)
    }

    class func imageWithPDFData( data: NSData?,  size: CGSize,  page: Int, preserveAspectRatio: Bool) -> UIImage?{
        
        if(data == nil || CGSizeEqualToSize(size, CGSizeZero) || page == 0){
            return UIImage();
        }
    
        var pdfImage: UIImage?
    
        let cacheFilename: String = self.cacheFileNameForResourceNamed(self.assetName!, size: size)
        let cacheFilePath: String = self.cacheFilePathForResourceNamed(cacheFilename)
        
        if(_shouldCacheOnDisk && NSFileManager.defaultManager().fileExistsAtPath(cacheFilePath))
        {
            pdfImage = UIImage(contentsOfFile: cacheFilePath)
        }
        else
        {
        
            let screenScale: CGFloat = UIScreen.mainScreen().scale
            let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
            let ctx: CGContextRef = CGBitmapContextCreate(nil, Int(size.width * screenScale), Int(size.height * screenScale), 8, 0, colorSpace, CGImageAlphaInfo.PremultipliedFirst.rawValue | CGBitmapInfo.ByteOrderDefault.rawValue)!
            CGContextScaleCTM(ctx, screenScale, screenScale);
            
            PDFResourceHelper.renderIntoContext(ctx, url:nil, data:data, size:size, page:page, preserveAspectRatio:preserveAspectRatio)
            if let image: CGImageRef = CGBitmapContextCreateImage(ctx){
                pdfImage =  UIImage(CGImage: image, scale: screenScale, orientation: UIImageOrientation.Up)
            }
            
            if(_shouldCacheOnDisk)
            {
                if let data = UIImagePNGRepresentation( pdfImage! ) {
                    data.writeToFile(cacheFilePath, atomically: false)
                }
            }
        }
        
        /**
         * Cache image to in memory if active
         */
        if (pdfImage != nil && _shouldCache)
        {
            _imagesCache?.setObject(pdfImage!, forKey: cacheFilename)
        }
    
        return pdfImage;
    }
    
    // Mark: Resource URLs
    
    class func imageWithPDFURL(URL: NSURL?,  size: CGSize,  page:Int) -> UIImage?{
        return self.imageWithPDFURL(URL, size:size, page:page, preserveAspectRatio:false)
    }
    
    class func imageWithPDFURL(URL: NSURL?,  size:CGSize,  page: Int, preserveAspectRatio:Bool) -> UIImage? {
        
        if(URL == nil || CGSizeEqualToSize(size, CGSizeZero) || page == 0){
            return nil
        }
    
        var pdfImage: UIImage?
    
        let cacheFilename: String = self.cacheFileNameForResourceNamed(self.assetName!, size: size)
        let cacheFilePath: String = self.cacheFilePathForResourceNamed(cacheFilename)
    
        /**
         * Check in Memory cached image before checking file system
         */
        if (_shouldCache)
        {
            pdfImage = _imagesCache!.objectForKey(cacheFilename) as? UIImage
            
            if (pdfImage != nil) {
                return pdfImage
            }
        }
        
        if(_shouldCacheOnDisk && NSFileManager.defaultManager().fileExistsAtPath(cacheFilePath))
        {
            pdfImage = UIImage(contentsOfFile: cacheFilePath)
            
        }
        else
        {
     
            let screenScale: CGFloat = UIScreen.mainScreen().scale
            let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
            let ctx: CGContextRef = CGBitmapContextCreate(nil, Int(size.width * screenScale), Int(size.height * screenScale), 8, 0, colorSpace, CGImageAlphaInfo.PremultipliedFirst.rawValue | CGBitmapInfo.ByteOrderDefault.rawValue)!
            CGContextScaleCTM(ctx, screenScale, screenScale);
        
            PDFResourceHelper.renderIntoContext(ctx, url:URL, data:nil, size:size, page:page, preserveAspectRatio:preserveAspectRatio)
            if let image: CGImageRef = CGBitmapContextCreateImage(ctx){
                pdfImage =  UIImage(CGImage: image, scale: screenScale, orientation: UIImageOrientation.Up)
            }
        
            if(_shouldCacheOnDisk)
            {
                if let data = UIImagePNGRepresentation( pdfImage! ) {
                    data.writeToFile(cacheFilePath, atomically: false)
                }
            }
        }
    
        /**
         * Cache image to in memory if active
         */
        if (pdfImage != nil && _shouldCache)
        {
            _imagesCache?.setObject(pdfImage!, forKey: cacheFilename)
        }
    
        return pdfImage;
    }

    class func imageWithPDFURL(URL: NSURL?,  size: CGSize) -> UIImage?{
        return self.imageWithPDFURL(URL, size:size, page:1, preserveAspectRatio:false)
    }
    
    private class func imageWithPDFURL(URL: NSURL?, fitSize size: CGSize,  page: Int) -> UIImage?{
        return self.imageWithPDFURL(URL, size:size, page:page, preserveAspectRatio:true)
    }
    
    class func imageWithPDFURL(URL: NSURL?, fitSize size: CGSize) -> UIImage?{
        return self.imageWithPDFURL(URL, fitSize:size, page:1)
    }
    
    class func imageWithPDFURL(URL: NSURL?,  width: CGFloat,  page: Int) -> UIImage?{
    
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForURL(URL, page:page)
        let aspectRatio: CGFloat = mediaRect.size.width / mediaRect.size.height;
    
        let size: CGSize = CGSizeMake( width, ceil( width / aspectRatio ));
    
        return self.imageWithPDFURL(URL, size:size, page:page)
    }
    
    class func imageWithPDFURL(URL: NSURL?,  width: CGFloat) -> UIImage? {
        return self.imageWithPDFURL(URL, width:width, page:1)
    }
    
    class func imageWithPDFURL(URL: NSURL?,  height: CGFloat,  page: Int) -> UIImage? {
    
        if ( URL == nil ){
            return nil
        }
    
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForURL(URL, page:page)
        let aspectRatio: CGFloat = mediaRect.size.width / mediaRect.size.height;
        let size: CGSize = CGSizeMake( ceil( height * aspectRatio ), height );

        return self.imageWithPDFURL(URL, size:size, page:page)
    }
    
    class func imageWithPDFURL(URL: NSURL?,  height: CGFloat) -> UIImage? {
        return self.imageWithPDFURL(URL, height:height, page:1)
    }
    
    class func originalSizeImageWithPDFURL( URL: NSURL?,  page: Int) -> UIImage? {
    
        if ( URL == nil ){
            return nil
        }
    
        let mediaRect: CGRect = PDFResourceHelper.mediaRectForURL(URL, page:page)
    
        return self.imageWithPDFURL(URL, size:mediaRect.size, page:page, preserveAspectRatio:true)
    }
    
    class func originalSizeImageWithPDFURL(URL: NSURL?) -> UIImage? {
        return self.originalSizeImageWithPDFURL(URL, page:1)
    }
    
    // Mark: Cacheing
    private class func cacheFileNameForResourceNamed(resourceName: String, size: CGSize) -> String{
        return String(format: "%@_%dX%d@%dx",resourceName, Int(size.width), Int(size.height), Int(self.screenScale()) )
    }
    
    private class func cacheFilePathForResourceNamed(resourceName: String,  size: CGSize) -> String{
        let fileName: String = self.cacheFileNameForResourceNamed(resourceName, size: size)
        return self.cacheFilePathForResourceNamed(fileName)
    }
    
    private class func cacheFilePathForResourceNamed(cacheResourseName: String) -> String{
        
        let fileManager: NSFileManager = NSFileManager.defaultManager()
        let documentsDirectoryPath: NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let cacheDirectory = String(format: "%@/%@", documentsDirectoryPath, cachedAssetsDirectory)
        do{
            try  fileManager.createDirectoryAtPath(cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }catch{
            print ("CACHES DIRECTORY IMAGE+PDF CAN'T BE CREATED!")
        }
        
        return String(format:"%@/%@.png", cacheDirectory, cacheResourseName)
    }

}

