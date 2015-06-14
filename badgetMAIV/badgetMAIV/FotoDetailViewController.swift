//
//  FotoDetailViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 14/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class FotoDetailViewController: UIViewController {
    
    var image:UIImage?
    var imageViewBacck:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageViewBack = UIImageView(image: UIImage(named: "backbadges"))
        self.view.addSubview(imageViewBack)
        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar badge", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)
        
        imageViewBacck = UIImageView(image: image)
        imageViewBacck.contentMode = UIViewContentMode.ScaleAspectFit
        imageViewBacck.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        var center = (self.view.bounds.size.width - imageViewBacck.frame.size.width) / 2.0
        imageViewBacck.frame = CGRect(x: center, y: 100, width: 300, height: 300)
        self.view.addSubview(imageViewBacck)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonActionBack(sender:UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true);
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.imageViewBacck.removeFromSuperview()
        
        super.viewDidDisappear(animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
