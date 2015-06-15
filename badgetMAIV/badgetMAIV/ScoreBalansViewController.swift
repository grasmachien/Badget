//
//  ScoreBalansViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 15/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ScoreBalansViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var winData = [NSManagedObject]()
    var userData = [NSManagedObject]()
    var username:String = "";
    var score:String?
    var labelscore:UILabel!
    var labelusername:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageViewBack = UIImageView(image: UIImage(named: "scorebord"))
        self.view.addSubview(imageViewBack)
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var error:NSError?
        userData = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        for data in userData as [NSManagedObject] {
            
            if((data.valueForKey("naaam")) != nil){
                username = data.valueForKey("naaam")! as! String
            }
            
        }
        

        
        Alamofire.request(.GET, "http://192.168.0.114/2014-2015/MAIV/Badget/Badget/site/api/data/balanstop")
            .responseJSON { (request, response, data, error) -> Void in
                println(request)
                println(response)
                println(error)
                println(data)
//                self.winData = NSArray(data);
        }
        

        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar badge", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)
        
        self.labelscore = UILabel(frame: CGRectMake(0, 0, 200, 21))
        self.labelscore.center = CGPointMake(273, 158)
        self.labelscore.textAlignment = NSTextAlignment.Center
        self.labelscore.text = "\(self.score!) cl"
        self.labelscore.textColor = UIColor.whiteColor()
        self.view.addSubview(self.labelscore)
        
        self.labelusername = UILabel(frame: CGRectMake(0, 0, 200, 21))
        self.labelusername.center = CGPointMake(173, 158)
        self.labelusername.textAlignment = NSTextAlignment.Left
        self.labelusername.text = "\(self.username)"
        self.labelusername.textColor = UIColor.whiteColor()
        self.view.addSubview(self.labelusername)
        
        
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
