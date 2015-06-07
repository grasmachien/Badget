//
//  TextFieldTableViewCell.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 7/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    var textField:UITextField?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
        
        textField = UITextField(frame: CGRectMake(self.bounds.size.width - 220, 0, 200, self.bounds.size.height))
        textField?.textAlignment = NSTextAlignment.Right
        contentView.addSubview(textField!)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
