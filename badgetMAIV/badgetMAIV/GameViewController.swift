//
//  GameViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 3/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData
import Alamofire

class GameViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var userData = [NSManagedObject]()
    

    let motionManager = CMMotionManager()
    let pint = UIImageView()
    var timerr = NSTimer()
    var timerrstart = NSTimer()
    var username:String = "";

    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var error:NSError?
        userData = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        
        for data in userData as [NSManagedObject] {
            
            username = data.valueForKey("naaam")! as! String
            
        }
        
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "game"
        
    }

    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Fade
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false) 
        
        var randomRot: Double;
        randomRot = 0;
        
        var teller:Int;
        teller = 0;
        
        self.timerr = NSTimer.schedule(repeatInterval: 3) { timer in
            
            var aRandomInt = Int.random(0...10)
            var bewerkteRandomint:Double = Double(aRandomInt) / 10;
            println("RANDOM IS \(bewerkteRandomint)")
            randomRot = bewerkteRandomint;
            
            if(teller < 1){
                teller++
            }
    
        }
        
        self.pint.image = UIImage(named: "pint")
        self.pint.frame = CGRectMake(20, 250, 275, 377)
        self.pint.layer.anchorPoint = CGPointMake(0.5, 1.0);
        self.view.addSubview(pint)
        
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                
                let rotation = atan2(data.gravity.x, data.gravity.y) - M_PI
                
                println("ROTATION IS \(rotation)")
                
                var resRot = -rotation - randomRot;
                
                
                println("AANGEPASTE ROTATIE \(resRot)");
                
                UIView.animateWithDuration(0.2, animations: {
                    // animating `transform` allows us to change 2D geometry of the object
                    // like `scale`, `rotation` or `translate`
                
                        self?.pint.transform = CGAffineTransformMakeRotation(CGFloat(-rotation))

                    
                })
                
                if(teller == 1){
                    
                    if(rotation < -1 && rotation > -5.4){
                        println("game over")
                        self!.motionManager.stopDeviceMotionUpdates()
                        self?.timerr.invalidate()

    
                        let parameter = [
                            "tijd": "111",
                            "spel": "versus",
                            "username": self!.username
                        ]
                        
                        Alamofire.request(.POST, "http://192.168.0.114/2014-2015/MAIV/Badget/Badget/site/api/data", parameters: parameter)
                            .responseJSON { (request, response, JSON, error) in
                                println("REQUEST \(request)")
                                println("RESPONSE \(response)")
                                println("JSON \(JSON)")
                                println("ERROR \(error)")
                        }

                    }
                    
                }
                
            }
        }
        
        
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
