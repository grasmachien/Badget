//
//  ScoreLoopViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 15/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ScoreLoopViewController: UIViewController {
    
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
    
    var username1label:UILabel!
    var score1label:UILabel!
    var username2label:UILabel!
    var score2label:UILabel!
    var username3label:UILabel!
    var score3label:UILabel!

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
        
        
        Alamofire.request(.GET, "http://student.howest.be/matthias.brodelet/20142015/MA4/BADGET/api/data/lopentop", encoding: .JSON)
            .responseJSON { (request, response, data, error) -> Void in
                println(request)
                println(response)
                println(error)
                
                var json = JSON(data!)
                
                var username1 = json[0]["username"]
                var score1 = json[0]["score"]
                
                var username2 = json[1]["username"]
                var score2 = json[1]["score"]
                
                var username3 = json[2]["username"]
                var score3 = json[2]["score"]
                
                
                self.username1label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.username1label.center = CGPointMake(173, 260)
                self.username1label.textAlignment = NSTextAlignment.Left
                self.username1label.text = "\(username1)"
                self.username1label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.username1label)
                
                self.score1label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.score1label.center = CGPointMake(273, 260)
                self.score1label.textAlignment = NSTextAlignment.Center
                self.score1label.text = "\(score1) cl"
                self.score1label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.score1label)
                
                self.username2label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.username2label.center = CGPointMake(173, 298)
                self.username2label.textAlignment = NSTextAlignment.Left
                self.username2label.text = "\(username2)"
                self.username2label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.username2label)
                
                self.score2label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.score2label.center = CGPointMake(273, 298)
                self.score2label.textAlignment = NSTextAlignment.Center
                self.score2label.text = "\(score2) cl"
                self.score2label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.score2label)
                
                self.username3label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.username3label.center = CGPointMake(173, 336)
                self.username3label.textAlignment = NSTextAlignment.Left
                self.username3label.text = "\(username3)"
                self.username3label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.username3label)
                
                self.score3label = UILabel(frame: CGRectMake(0, 0, 200, 21))
                self.score3label.center = CGPointMake(273, 336)
                self.score3label.textAlignment = NSTextAlignment.Center
                self.score3label.text = "\(score3) cl"
                self.score3label.textColor = UIColor.whiteColor()
                self.view.addSubview(self.score3label)
                
        }
        
        
        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar badge", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)
        
        let replaybtn   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        replaybtn.frame = CGRectMake(50, 390, 220, 32)
        replaybtn.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        replaybtn.setTitle("Opnieuw spelen!", forState: UIControlState.Normal)
        replaybtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        replaybtn.addTarget(self, action: "replaybtn:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(replaybtn)
        
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
    
    func replaybtn(sender:UIButton!)
    {
        self.navigationController!.pushViewController(LoopViewController(), animated: true)
        
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
