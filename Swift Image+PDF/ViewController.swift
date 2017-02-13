//
//  ViewController.swift
//  Swift Image+PDF
//
//  Created by Roman Bambura on 2/26/16.
//  Copyright © 2016 Roman Bambura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UIView From PDF Use UIPDFView For perfect image sharpness animation
        let pdfView = UIPDFView(withName: "animalsCat", frame: CGRect(x: 10, y: 20, width: 100, height: 100) )
        pdfView.backgroundColor = UIColor.clear
        view.addSubview(pdfView)
        
         
        // UIImages From PDF With Disc Cache user/Documents/CachedAssets/
        // file will be cached with name animalsCat_100X100@2x // scale 2
        // animalsCat_100X100@1x // scale 1
        
        // Size To Fit
        if let pdfImage: UIImage = UIImage.imageWithPDFNamed("animalsCat", fitSize: CGSize(width:100, height:100)){
            
            let pdfImageView: UIImageView = UIImageView(image: pdfImage)
            pdfImageView.center = CGPoint(x:200, y:200)
            
            view.addSubview(pdfImageView)
        }
        

        if let pdfImage2: UIImage = UIImage.imageWithPDFNamed("animalsCat", size: CGSize(width:80, height:80)){
            
            let pdfImageView2: UIImageView = UIImageView(image: pdfImage2)
            pdfImageView2.center = CGPoint(x:200, y:290)
            
            view.addSubview(pdfImageView2)
        }
        
        // With Width
        if let pdfImage3: UIImage = UIImage.imageWithPDFNamed("animalsCat", width: 70){
            
            let pdfImageView3: UIImageView = UIImageView(image: pdfImage3)
            pdfImageView3.center = CGPoint(x:200, y:380)
            
            view.addSubview(pdfImageView3)
        }
        
        // With Height
        if let pdfImage4: UIImage = UIImage.imageWithPDFNamed("animalsCat", height: 40){
            
            let pdfImageView4: UIImageView = UIImageView(image: pdfImage4)
            pdfImageView4.center = CGPoint(x:200, y:440)
            
            view.addSubview(pdfImageView4)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

