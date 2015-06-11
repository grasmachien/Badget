//
//  InfoSliderView.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 2/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class InfoSliderView: UIView{
    
    let scrollView:UIScrollView;


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect){
        
        self.scrollView = UIScrollView(frame: frame)
        super.init(frame: frame)
        
        let imageViewBack = UIImageView(image: UIImage(named: "infoBack"))
        self.addSubview(imageViewBack)
        
        self.addSubview(self.scrollView)
        
        
        
        var images = ["1":"info2","2":"splashscreen","3":"info3"];
        self.createImageViews(images)
        
    }
    
    func createImageViews(images: NSDictionary){
        
        var xPosition = CGFloat(0);
        let fotos = images;
        
        for foto in fotos{
            
            let image = UIImage(named: String(foto.value as! NSString))
            let imageView = UIImageView(image:image)
            
            imageView.frame = CGRectMake(xPosition, 0, image!.size.width, image!.size.height)
            
            self.scrollView.addSubview(imageView)
            xPosition += image!.size.width
        }
        
        
        
        self.scrollView.contentSize = CGSizeMake(xPosition, 0)
        self.scrollView.pagingEnabled = true;
        self.scrollView.bounces = false;
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
