//
//  GameViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 3/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    

    let motionManager = CMMotionManager()
    let pint = UIImageView()
    var timerr = NSTimer()
    var timerrstart = NSTimer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
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
                    
                    if(rotation < -4){
                        println(" links")
                        self?.pint.transform = CGAffineTransformMakeRotation(CGFloat(-resRot))
                    }else{
                        self?.pint.transform = CGAffineTransformMakeRotation(CGFloat(resRot))
                    }
                    
                })
                
                if(teller == 1){
                    
                    if(resRot < -1 && resRot > -5.4){
                        println("game over")
                        self!.motionManager.stopDeviceMotionUpdates()
                        self?.timerr.invalidate()

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
