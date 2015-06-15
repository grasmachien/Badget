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
    
    var connectionsLabel: UILabel!
    let colorService = ColorServiceManager()

    let motionManager = CMMotionManager()
    let pint = UIImageView()
    var timerr = NSTimer()
    var timerrstart = NSTimer()
    var score:Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorService.delegate = self
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: false)
        
        let imageViewBackintro = UIImageView(image: UIImage(named: "backstabielerintro"))
        self.view.addSubview(imageViewBackintro)
        
        let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        backbutton.frame = CGRectMake(50, 440, 220, 32)
        backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        backbutton.setTitle("Terug naar overzicht", forState: UIControlState.Normal)
        backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backbutton)
        
    }
    
    func buttonActionBack(sender:UIButton!)
    {
        self.navigationController!.pushViewController(ChallengeViewController(), animated: true)
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        startGame()
        self.colorService.sendColor("yellow")
    }
    
    func gameOver(){
        
        self.motionManager.stopDeviceMotionUpdates()
        self.timerr.invalidate()
        
        self.colorService.sendColor("red")
        
        let resultBalance = EindschermBalanceViewController()
        resultBalance.gewonnenverloren = "verloren"
        self.navigationController!.pushViewController(resultBalance, animated: true)
    }

    
    func startGame(){
        
        let verlorenback = UIImageView(image: UIImage(named: "backstabieler"))
        self.view.addSubview(verlorenback)
        
        var randomRot: Double;
        randomRot = 0;
        
        var teller:Int;
        teller = 0;
        
        self.timerr = NSTimer.schedule(repeatInterval: 3) { timer in
            
            self.score+=5;
            
            var aRandomInt = Int.random(0...10)
            var bewerkteRandomint:Double = Double(aRandomInt) / 10;
            println("RANDOM IS \(bewerkteRandomint)")
            randomRot = bewerkteRandomint;
            
            if(teller < 1){
                teller++
            }
        }
        
        self.pint.image = UIImage(named: "pint")
        self.pint.frame = CGRectMake(20, 340, 275, 377)
        self.pint.layer.anchorPoint = CGPointMake(0.5, 1.0);
        self.view.addSubview(pint)
        
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion!, error: NSError!) in
                
                let rotation = atan(data.gravity.x) - M_PI
                var rot = data.gravity.x*3;
                var resRot = rot - randomRot;
                
                UIView.animateWithDuration(0.2, animations: {
                    // animating `transform` allows us to change 2D geometry of the object
                    // like `scale`, `rotation` or `translate`
                    
                    self?.pint.transform = CGAffineTransformMakeRotation(CGFloat(resRot))
                    
                })
                
                if(teller == 1){
                    
                    if(rot < -0.7 && rot > -3.0){
                        self!.gameOver()
                    }
                    
                    if(rot > 0.7 && rot < 3.0){
                        self!.gameOver()
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
        
            if String(stringInterpolationSegment: connectedDevices).isEmpty {
                
            }else{
                let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                button.frame = CGRectMake(50, 390, 220, 32)
                button.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
                button.setTitle("Challenge Starten", forState: UIControlState.Normal)
                button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(button)
            }

        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            switch colorString {
            case "red":
                
                
                self.motionManager.stopDeviceMotionUpdates()
                self.timerr.invalidate()
                
                let resultBalance = EindschermBalanceViewController()
                resultBalance.gewonnenverloren = "gewonnen"
                resultBalance.dataFromScore = self.score
                self.navigationController!.pushViewController(resultBalance, animated: true)
                
            case "yellow":
                println("start game")
                self.startGame()
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}