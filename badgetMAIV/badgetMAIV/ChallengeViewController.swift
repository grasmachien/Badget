//
//  ChallengeViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 1/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreMotion


class ChallengeViewController: UIViewController {
    
     let motionManager = CMMotionManager()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "map"
        self.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map-icon"), tag: 1)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        

        // Do any additional setup after loading the view.
         super.viewDidLoad()
       
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
//        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(accelerometerData: CMAccelerometerData!, error:NSError!)in
//            self.outputAccelerationData(accelerometerData.acceleration)
//
//        })
        
        motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(gyroData: CMGyroData!, error: NSError!)in
            self.outputRotationData(gyroData.rotationRate)

        })
        
        
    }
    
    func outputAccelerationData(acceleration:CMAcceleration)
    {
        println("acceleration")
        println(acceleration.x)
        println(acceleration.y)
        println(acceleration.z)
    }
    
    func outputRotationData(rotation:CMRotationRate)
    {
     println("rotation")
        println(rotation.x)
        println(rotation.y)
        println(rotation.z)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
