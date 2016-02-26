# UIImage+PDF Swift
UIImage+PDF provides a UIImage class category method to render a UIImage from any PDF stored in the application bundle. The motivation for this was to enable the easy use of scaleable vector assets in Swift iOS apps.

#Usage
Add the sources files in the UIImage+PDF sub folder to your project.

# UIPDFView
Use UIPDFView for animation
```swift
UIPDFView(name: String, frame: CGRect)

Sample: 
let pdfView = UIPDFView(name: "animalsCat", frame: CGRectMake(10, 20, 100, 100))
        pdfView.backgroundColor = UIColor.clearColor()
        view.addSubview(pdfView)
```

# UIImage 
PDF asset name used without extension

Sample: 
```swift
if let pdfImage: UIImage = UIImage.imageWithPDFNamed("animalsCat", fitSize: CGSizeMake(100, 100)){
            
            let pdfImageView: UIImageView = UIImageView(image: pdfImage)
            pdfImageView.center = CGPointMake(200, 200)
            
            view.addSubview(pdfImageView)
 }
```
PDF Asset with size to fit
```swift
UIImage.imageWithPDFNamed(name: String, fitSize: CGSize)
```


PDF Asset with Size
```swift
UIImage.imageWithPDFNamed(name: String, size: CGSize)
```

PDF Asset with Width
```swift
UIImage.imageWithPDFNamed(name: String, width: CGFloat)
```

PDF Asset with Height
```swift
UIImage.imageWithPDFNamed(name: String, height: CGFloat)
```

# Disk Cacheing 
Cached PDF assets to PNG images with readable names and scale factor ready to reuse.<br/>
UIImage+PDF now transparently caches all rendered PDFs in Application_Home/Documents/CachedAssets. This substantially improves application latency with large PDFs, especially on larger devices. To disable disk cacheing, call:
```swift
UIImage.shouldCacheOnDisk = false
```

# Memory Cacheing
UIImage+PDF can now use NSCache to cache rendered PDFs in memory. This feature is disabled by default. To enable it call:
```swift
UIImage.shouldCacheInMemory = true
```

# PDF file size
By default Adobe Illustrator saves exported PDFs very inefficiently. For best results, select File -> Save a Copy, select PDF format and then uncheck all the general options. Once you are ready to ship your app, run all your PDF assets through <a href="https://panic.com/blog/shrinkit-1-0/">ShrinkIt</a> (see below).

Other vector graphics editors which natively use the OSX Quartz renderer, such as <a href="http://www.sketchapp.com">Sketch</a>, will create much more compact PDFs.

The amazing devs at <a href="http://www.panic.com">Panic</a> have now released a PDF shrinking utility, <a href="https://panic.com/blog/shrinkit-1-2/">ShrinkIt</a>, which should take a lot of the pain out of a vector asset workflow.

#Licence
Copyright 2016 Roman Bambura - <a href="http://sonettic.com">@RomanBambura.</a> All rights reserved.

Permission is given to use this source code file without charge in any project, commercial or otherwise, entirely at your risk, with the condition that any redistribution (in part or whole) of source code must retain this copyright and permission notice. Attribution in compiled projects is appreciated but not required.

#Further Reading
<a href="https://twitter.com/mattgemmell">Matt Gemmell </a> has an excellent article on his blog explaining <a href="http://mattgemmell.com/using-pdf-images-in-ios-apps/">how to use PDF images in iOS apps.</a>

#UIImage+PDF Objective-C
Nigel Timothy Barber <a href="https://github.com/mindbrix/UIImage-PDF">UIImage-PDF</a>
