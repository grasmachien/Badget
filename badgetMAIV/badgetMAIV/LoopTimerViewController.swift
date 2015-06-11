//
//  LoopTimerViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 5/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import CoreData

class LoopTimerViewController: UIViewController, CLLocationManagerDelegate {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var username = [NSManagedObject]()
    var locationManager: CLLocationManager!
    var seconden = 60;
    let redLayer = CALayer()
    var label: UILabel!
    var timerr = NSTimer()
    var labelTimeUp: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var error:NSError?
        username = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "lopen"
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageViewBack = UIImageView(image: UIImage(named: "backsnelpint"))
        self.view.addSubview(imageViewBack)
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 1
        self.locationManager.activityType = CLActivityType.AutomotiveNavigation
        
        self.label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        self.label.center = CGPointMake(160, 284)
        self.label.textAlignment = NSTextAlignment.Center
        self.label.text = "I'am a test label"
        self.label.textColor = UIColor.whiteColor()
        self.view.addSubview(self.label)
        
        self.labelTimeUp = UILabel(frame: CGRectMake(0, 0, 200, 21))
        self.labelTimeUp.center = CGPointMake(160, 184)
        self.labelTimeUp.textAlignment = NSTextAlignment.Center
        self.labelTimeUp.text = "I'am a test label"
        self.labelTimeUp.textColor = UIColor.whiteColor()
        self.view.addSubview(self.labelTimeUp)
        
        self.timerr = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        setupTimer()

        // Do any additional setup after loading the view.
    }
    
    func setupTimer() {
        
        redLayer.frame = CGRect(x: 320-50, y: 120, width: self.seconden, height: 50)
        redLayer.backgroundColor = UIColor.yellowColor().CGColor
        self.view.layer.addSublayer(redLayer)
        
        
    }
    
    func update() {
        
        if( seconden > 0){
            
            seconden--;
            
            UIView.animateWithDuration(1.0, animations: {
                
                self.redLayer.frame = CGRect(x: 320-50, y: 120, width: self.seconden, height: 50)
                
            })
        }
        
        println(seconden)
        
        if (seconden == 0){
            println("time is up")
            self.timerr.invalidate()
            self.labelTimeUp.text = "te laat! \(seconden)"
            
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
        //println("Did update locations: \(lastLocation.coordinate.latitude) - \(lastLocation.coordinate.longitude)")
        
        let locB = CLLocation(latitude: 50.819594, longitude: 3.274044)
        let dist = lastLocation.distanceFromLocation(locB)
        
        println( "De afstand is \(dist)");
        
        
        if(dist < 25){
            self.label.text = "ja je bent er! \(round(dist)) \(seconden)"
            self.timerr.invalidate()
            
            var sec = String(seconden)
            let parameter = [
                "tijd": sec,
                "spel": "snellerdanjepint",
            ]
            
            Alamofire.request(.POST, "http://192.168.0.114/2014-2015/MAIV/Badget/Badget/site/api/data/snellerdanjepint", parameters: parameter)
            
        }else{
            self.label.text = "verder lopen! \(round(dist)) \(seconden)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
