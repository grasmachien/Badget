//
//  rect.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 2/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class rect: UIView {
    
    override init(frame: CGRect){
        super.init(frame: CGRect(x: 10.0, y: 10.0, width: 200.0, height: 40.0))

        
        self.backgroundColor = UIColor.whiteColor()
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
