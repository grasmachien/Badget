//
//  GameScene.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 4/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    
    
//    let motionManager: CMMotionManager = CMMotionManager()
    

    
//    motionManager.accelerometerUpdateInterval = 0.2
//    motionManager.gyroUpdateInterval = 0.2
//    
//    //        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(accelerometerData: CMAccelerometerData!, error:NSError!)in
//    //            self.outputAccelerationData(accelerometerData.acceleration)
//    //
//    //        })
//    
//    if motionManager.gyroAvailable {
//    println("gyro data available")
//    motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(gyroData: CMGyroData!, error: NSError!)in
//    self.outputRotationData(gyroData.rotationRate)
//    
//    })
//    }else{
//    println("gyro data not available")
//    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        println("game view")
        
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
    
    
    

}
