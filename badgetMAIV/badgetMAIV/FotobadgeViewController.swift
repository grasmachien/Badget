//
//  FotobadgeViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 14/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class FotobadgeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageViewBack = UIImageView(image: UIImage(named: "fotobadgeback"))
        self.view.addSubview(imageViewBack)
        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar badges", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonActionBack(sender:UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true);
        
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
