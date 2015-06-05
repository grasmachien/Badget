//
//  LoopViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 3/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreLocation

class LoopViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var timer = 10;
    let redLayer = CALayer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "lopen"
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 1
        self.locationManager.activityType = CLActivityType.AutomotiveNavigation
        
        var timerr = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        if( timer == 0){
            timerr.invalidate()
        }

        setupTimer()
        
    }
    
    func setupTimer() {
        
        redLayer.frame = CGRect(x: 320-50, y: 120, width: self.timer, height: 50)
        redLayer.backgroundColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(redLayer)
        
        
    }
    
    func update() {
        
        if( timer > 0){
        
            timer--;
            
            UIView.animateWithDuration(1.0, animations: {
                
                self.redLayer.frame = CGRect(x: 320-50, y: 120, width: self.timer, height: 50)
                
            })
        }
        
        println(timer)
        
        if (timer == 0){
//            println("time is up biatch")
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
       println("De status is veranderd naar \(status.rawValue)")
        
        switch( CLLocationManager.authorizationStatus() ){
            case CLAuthorizationStatus.NotDetermined:
                println("Location service status nog niet bekend")
                askForLocationServicePermission();
            
            case CLAuthorizationStatus.Restricted:
                println("Location service status restricted")
                showAlert();
            
            case CLAuthorizationStatus.Denied:
                println("Location service status denied")
                showAlert();
            
            case CLAuthorizationStatus.AuthorizedWhenInUse:
                println("Location service status only when in use")
                
                fallthrough
            
            case CLAuthorizationStatus.AuthorizedAlways:
                println("Location service status always")
                startUpdatingLocation()

        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        let lastLocation = locations.last as! CLLocation
        println("Did update locations: \(lastLocation.coordinate.latitude) - \(lastLocation.coordinate.longitude)")
        
        let locA = CLLocation(latitude: 50.819628, longitude: 3.274238)
        let locB = CLLocation(latitude: 50.81948, longitude: 3.25773)
        let dist = lastLocation.distanceFromLocation(locA)
        
        println( "De afstand is \(dist)");
        
        if(dist < 15){
            println("je kan de challenge starten!")
        }else{
            println("begeef je naar de maes stand!")
        }
    }
    
    func startUpdatingLocation(){
        println("Start updating location")
        self.locationManager.startUpdatingLocation()
        
    }
    
    func showAlert(){
        let alert = UIAlertView(title: "oops", message: "U gaf geen toestemming", delegate: nil, cancelButtonTitle: "ok")
        alert.show()
    }
    
    func askForLocationServicePermission(){
        println("Ask for permission")
        self.locationManager.requestWhenInUseAuthorization()
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
