//
//  ResultaatFotoViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 10/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit

class ResultaatFotoViewController: UIViewController {
    
    var dataFromImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let imageViewBack = UIImageView(image: UIImage(named: "resultaat"))
        self.view.addSubview(imageViewBack)
        
        if let myData = self.dataFromImage {
            // do something with myData
            
//            var imgwidth = self.dataFromImage!.size.width;
//            var imgheight = self.dataFromImage!.size.height;
//            var ratio = imgwidth/imgheight;
//            
//            var newWidth = imgwidth/imgwidth*200;
//            var newHeight = imgheight/imgheight*200;
            
            
            let imageViewBacck = UIImageView(image: self.dataFromImage!)
            imageViewBacck.frame = CGRect(x: 0, y: 150, width: self.dataFromImage!.size.width, height: self.dataFromImage!.size.height)
            self.view.addSubview(imageViewBacck)
            println("toon de binnengekomen data")
            println(self.dataFromImage)
            
        } else {
            // no data was obtained
            println("geen data")
        }
        
        let overview   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        overview.frame = CGRectMake(50, 420, 220, 32)
        overview.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        overview.setTitle("Terug naar overzicht", forState: UIControlState.Normal)
        overview.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        overview.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(overview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.navigationController!.pushViewController(ChallengeViewController(), animated: true)
    }
    
    func imageResize(imageObj:UIImage, sizeChange:CGSize)-> UIImage {
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() // !!!
        return scaledImage
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
