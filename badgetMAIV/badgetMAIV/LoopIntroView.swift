//
//  LoopIntroView.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 5/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class LoopIntroView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect){
        
        super.init(frame: CGRect())
        self.backgroundColor = UIColor.redColor()
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
