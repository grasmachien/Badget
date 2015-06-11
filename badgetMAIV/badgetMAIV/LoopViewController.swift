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
    var label: UILabel!
    let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "lopen"
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageViewBack = UIImageView(image: UIImage(named: "backsnelpintintro"))
        self.view.addSubview(imageViewBack)

        // Do any additional setup after loading the view.
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 1
        self.locationManager.activityType = CLActivityType.AutomotiveNavigation
        
        
        self.label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        self.label.center = CGPointMake(160, 370)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.text = "Ga naar de maes stand!"
        self.label.textColor = UIColor.whiteColor()
        self.view.addSubview(self.label)
        
        
        
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

        let locA = CLLocation(latitude: 50.819857, longitude: 3.267092)
        let dist = lastLocation.distanceFromLocation(locA)
        
        
        if(dist < 25){
            
            self.label.text = "ok! \(round(dist))"
            
            button.frame = CGRectMake(50, 30, 220, 32)
            button.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
            button.setTitle("Begin!", forState: UIControlState.Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            //self.label.removeFromSuperview()
            
        }else{
            println("begeef je naar de maes stand!")
            self.label.text = "Je bent \(round(dist)) meter van de stand!"
            button.removeFromSuperview()
        }
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.locationManager.stopUpdatingLocation()
        self.navigationController!.pushViewController(LoopTimerViewController(), animated: true)
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
    
    override func loadView(){
        
        var bounds = UIScreen.mainScreen().bounds;
        self.view = LoopIntroView(frame:bounds);
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
