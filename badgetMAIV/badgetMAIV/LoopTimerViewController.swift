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
    
    var userData = [NSManagedObject]()
    var locationManager: CLLocationManager!
    var seconden = 0;
    let redLayer = CALayer()
    var label: UILabel!
    var timerr = NSTimer()
    var username:String = "";
    var pintvol:UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var error:NSError?
        userData = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        
        for data in userData as [NSManagedObject] {
            
            if((data.valueForKey("naaam")) != nil){
                username = data.valueForKey("naaam")! as! String
            }

        }
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageViewBack = UIImageView(image: UIImage(named: "backsnelpint"))
        self.view.addSubview(imageViewBack)
        
        let pintleeg = UIImageView(image: UIImage(named: "pintleeg"))
        pintleeg.frame = CGRectMake(87, 155, 153, 341)
        self.view.addSubview(pintleeg)
        
        pintvol = UIImageView(image: UIImage(named: "pintvol"))
        pintvol.frame = CGRectMake(85, 154, 153, 344)
        self.view.addSubview(pintvol)
        
        let handen = UIImageView(image: UIImage(named: "handen"))
        handen.frame = CGRectMake(2, 175, 320, 344)
        self.view.addSubview(handen)
        
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
        
        let secretbtn   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        secretbtn.frame = CGRectMake(50, 0, 220, 32)
        secretbtn.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
        secretbtn.setTitle("win", forState: UIControlState.Normal)
        secretbtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        secretbtn.addTarget(self, action: "buttonActionsecret:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(secretbtn)
        
        
        self.timerr = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        setupTimer()

        // Do any additional setup after loading the view.
    }
    
    func buttonActionsecret(sender:UIButton!)
    {
        
        self.timerr.invalidate()
        self.locationManager.stopUpdatingLocation()
        
        let winpagina = UIImageView(image: UIImage(named: "winlopen"))
        self.view.addSubview(winpagina)
        
        var sec = String(seconden)
        let parameter = [
            "tijd": sec,
            "spel": "snellerdanjepint",
            "username": self.username
        ]
        
        Alamofire.request(.POST, "http://student.howest.be/matthias.brodelet/20142015/MAIV/BADGET/api/data", parameters: parameter)
        
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
        let score = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext!)
        
        score.setValue(sec, forKey: "lopenscore")
        
        var error:NSError?
        
        if !appDelegate.managedObjectContext!.save(&error) {
            println("could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    func setupTimer() {
        
        
        redLayer.backgroundColor = UIColor.yellowColor().CGColor
        redLayer.frame = CGRect(x: 0, y: self.seconden, width: 260, height: 400)
        
        self.pintvol.layer.mask = redLayer;
        
    }
    
    
    func update() {
        
        if( seconden < 332){
            
            seconden++
            seconden++
            seconden++
            seconden++
            
            UIView.animateWithDuration(1.0, animations: {
                
                self.redLayer.frame = CGRect(x: 0, y: self.seconden, width: 260, height: 400)
                
            })
        }
        
        println(seconden)
        
        if (seconden == 332){
            println("time is up")
            self.timerr.invalidate()
            
            let verlorenpagina = UIImageView(image: UIImage(named: "verlorenpagina"))
            self.view.addSubview(verlorenpagina)
            
            var verlabel = UILabel(frame: CGRectMake(0, 0, 200, 21))
            verlabel.center = CGPointMake(160, 284)
            verlabel.textAlignment = NSTextAlignment.Center
            verlabel.text = "Je pint is leeg"
            verlabel.textColor = UIColor.whiteColor()
            self.view.addSubview(verlabel)
            
            let backbutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            backbutton.frame = CGRectMake(50, 440, 220, 32)
            backbutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
            backbutton.setTitle("Terug naar overzicht", forState: UIControlState.Normal)
            backbutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            backbutton.addTarget(self, action: "buttonActionBack:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(backbutton)
            
            let rebutton   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            rebutton.frame = CGRectMake(50, 380, 220, 32)
            rebutton.setBackgroundImage(UIImage(named: "btn"), forState: UIControlState.Normal)
            rebutton.setTitle("opnieuw proberen", forState: UIControlState.Normal)
            rebutton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            rebutton.addTarget(self, action: "buttonActionretry:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(rebutton)
            
            
        }
        
    }
    
    func buttonActionretry(sender:UIButton!)
    {
        self.navigationController!.pushViewController(LoopViewController(), animated: true)
        
    }
    
    func buttonActionBack(sender:UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true);
        
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
        
        if(dist < 25){
            
            self.timerr.invalidate()
            self.locationManager.stopUpdatingLocation()
            
            var sec = String(seconden)
            let parameter = [
                "tijd": sec,
                "spel": "snellerdanjepint",
                "username": self.username
            ]
            
            Alamofire.request(.POST, "http://student.howest.be/matthias.brodelet/20142015/MAIV/BADGET/api/data", parameters: parameter)
            
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
            let score = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext!)
            
            score.setValue(sec, forKey: "lopenscore")
            
            var error:NSError?
            
            if !appDelegate.managedObjectContext!.save(&error) {
                println("could not save \(error), \(error?.userInfo)")
            }
            
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
