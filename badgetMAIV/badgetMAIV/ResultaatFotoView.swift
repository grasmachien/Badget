//
//  ResultaatFotoView.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 10/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class ResultaatFotoView: UIView {
    

    override init(frame: CGRect){
        
        super.init(frame: CGRect())
        
        let imageViewBack = UIImageView(image: UIImage(named: "resultaat"))
        self.addSubview(imageViewBack)
        
        let overview   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        overview.frame = CGRectMake(50, 420, 220, 32)
        overview.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        overview.setTitle("Terug naar overzicht", forState: UIControlState.Normal)
        overview.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        self.addSubview(overview)
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
