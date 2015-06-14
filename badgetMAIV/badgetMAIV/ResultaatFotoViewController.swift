//
//  ResultaatFotoViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 10/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData

class ResultaatFotoViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    
    var dataFromImage : UIImage?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var tabArray = self.tabBarController?.tabBar.items as NSArray!
        var tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        tabItem.badgeValue = "1"
        
        
        let imageViewBack = UIImageView(image: UIImage(named: "resultaat"))
        self.view.addSubview(imageViewBack)
        
        if let myData = self.dataFromImage {
            // do something with myData
            
            var imageViewBacck = UIImageView(image: self.dataFromImage!)
            imageViewBacck.contentMode = UIViewContentMode.ScaleAspectFit
            imageViewBacck.frame = CGRect(x: 0, y: 80, width: 200, height: 200)
            var center = (self.view.bounds.size.width - imageViewBacck.frame.size.width) / 2.0
            imageViewBacck.frame = CGRect(x: center, y: 80, width: 200, height: 200)
            self.view.addSubview(imageViewBacck)
            
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
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        let usernames = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext!)
        
        var imgdata:NSData = UIImagePNGRepresentation(self.dataFromImage)
        usernames.setValue(imgdata, forKey: "image")
        
        var error:NSError?
        
        if !appDelegate.managedObjectContext!.save(&error) {
            println("could not save \(error), \(error?.userInfo)")
        }
        
        
        
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
