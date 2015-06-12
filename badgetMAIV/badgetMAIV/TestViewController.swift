//
//  GameViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 3/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreMotion


class TestViewController: UIViewController {
    
    var connectionsLabel: UILabel!
    
    let motionManager = CMMotionManager()
    let pint = UIImageView()
    var timerr = NSTimer()
    var timerrstart = NSTimer()
    var score:Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: false)
        
        let imageViewBackintro = UIImageView(image: UIImage(named: "backstabielerintro"))
        self.view.addSubview(imageViewBackintro)
        
        startGame()
        
    }

    
    func startGame(){
        
        let verlorenback = UIImageView(image: UIImage(named: "backstabieler"))
        self.view.addSubview(verlorenback)
        
        var randomRot: Double;
        randomRot = 0;
        
        var teller:Int;
        teller = 0;
        
        self.timerr = NSTimer.schedule(repeatInterval: 1) { timer in
            
            self.score+=5;
            
            var aRandomInt = Int.random(0...10)
            var bewerkteRandomint:Double = Double(aRandomInt) / 15;
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
                
                let rotation = atan(data.gravity.x) - M_PI
                var rot = data.gravity.x*3;
                println("ROTATION IS \(rot)")
                
                var resRot = rot - randomRot;
                println("AANGEPASTE ROTATIE \(rot)");
                
                UIView.animateWithDuration(0.2, animations: {
                    // animating `transform` allows us to change 2D geometry of the object
                    // like `scale`, `rotation` or `translate`
                    
                    self?.pint.transform = CGAffineTransformMakeRotation(CGFloat(rot))
                    
                })
                
                if(teller == 1){
                    
                    if(rot < -0.7 && rot > -3.0){
                        println("game over left")
                        
//                        self!.motionManager.stopDeviceMotionUpdates()
//                        self?.timerr.invalidate()
                        
                        
                    }
                    
                    if(rot > 0.7 && rot < 3.0){
                        println("game over right")
                        
//                        self!.motionManager.stopDeviceMotionUpdates()
//                        self?.timerr.invalidate()
                        
                        
                    }
                    
                }
                
            }
        }
        
    }
    
}

