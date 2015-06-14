//
//  FotobadgeViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 14/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import Social

class FotobadgeViewController: UIViewController {
    
    var image:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageViewBack = UIImageView(image: UIImage(named: "fotobadgeback"))
        self.view.addSubview(imageViewBack)
        
        let bekijkbtn   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        bekijkbtn.frame = CGRectMake(50, 390, 220, 32)
        bekijkbtn.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        bekijkbtn.setTitle("Bekijk foto", forState: UIControlState.Normal)
        bekijkbtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        bekijkbtn.addTarget(self, action: "buttonActionBekijk:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(bekijkbtn)
        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar badges", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)
        
        
        
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)){
            
            let fbbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            fbbutton.frame = CGRectMake(50, 340, 220, 32)
            fbbutton.setBackgroundImage(UIImage(named: "fbbtn"), forState: UIControlState.Normal)
            fbbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            fbbutton.addTarget(self, action: "buttonActionfb:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(fbbutton)
        }
        
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonActionBack(sender:UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true);
        
    }
    
    func buttonActionfb(sender:UIButton!)
    {
       let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        presentViewController(facebookVC, animated: true, completion: { () -> Void in
            
            
        })
        
        facebookVC.setInitialText("Foto badge behaald!")
        facebookVC.addImage(UIImage(named: "badgefoto"))
        
    }
    
    func buttonActionBekijk(sender:UIButton!)
    {
        let fotoDetail = FotoDetailViewController()
        fotoDetail.image = self.image
        self.navigationController!.pushViewController(fotoDetail, animated: true)
        
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
