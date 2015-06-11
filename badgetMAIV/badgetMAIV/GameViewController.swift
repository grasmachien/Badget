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
    
    var connectionsLabel: UILabel!
    let colorService = ColorServiceManager()

    let motionManager = CMMotionManager()
    let pint = UIImageView()
    var timerr = NSTimer()
    var timerrstart = NSTimer()
    var username:String = "";
    var score:Int = 0;
    
    
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
        
    }

    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorService.delegate = self
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: false)
        
        let imageViewBackintro = UIImageView(image: UIImage(named: "backstabielerintro"))
        self.view.addSubview(imageViewBackintro)
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        startGame()
    }
    
//    func changeColor(color : UIColor) {
//        UIView.animateWithDuration(0.2) {
////            let imageViewBackintro = UIImageView(image: UIImage(named: "backstabielerintro"))
////            self.view.addSubview(imageViewBackintro)
//        }
//    }
    
    func startGame(){
        
        let verlorenback = UIImageView(image: UIImage(named: "backstabieler"))
        self.view.addSubview(verlorenback)
        
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
                            self!.colorService.sendColor("red")
                        
                            let verlorenback = UIImageView(image: UIImage(named: "verlorenpagina"))
                            self!.view.addSubview(verlorenback)
                        
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

}

extension GameViewController : ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            //self.connectionsLabel.text = "Connections: \(connectedDevices)"
            println("Connections: \(connectedDevices)")
            
            let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            button.frame = CGRectMake(50, 390, 220, 32)
            button.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
            button.setTitle("Challenge Starten", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            
            
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                
                let verlorenback = UIImageView(image: UIImage(named: "winstabieler"))
                self.view.addSubview(verlorenback)
                
                self.motionManager.stopDeviceMotionUpdates()
                self.timerr.invalidate()
                
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}