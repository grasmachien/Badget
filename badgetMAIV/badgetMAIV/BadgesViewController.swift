//
//  BadgesViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 2/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData

class BadgesViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var userData = [NSManagedObject]()
    var balans:String = "";
    var lopen:String = "";
    var foto:UIImage!
    var fotodata:NSData!
    var fotobutton:UIButton!
    var loopbutton:UIButton!
    var balansbutton:UIButton!
    var balansNot:UIImageView!
    var lopenNot:UIImageView!
    var fotoNot:UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        self.tabBarItem = UITabBarItem(title: "badges", image: UIImage(named: "badgeIcon"), tag: 2)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var tabArray = self.tabBarController?.tabBar.items as NSArray!
        var tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        tabItem.badgeValue = nil
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var error:NSError?
        userData = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        for data in userData as [NSManagedObject] {
            
            if((data.valueForKey("balansscore")) != nil){
                self.balans = data.valueForKey("balansscore")! as! String
            }
            
            if((data.valueForKey("lopenscore")) != nil){
                self.lopen = data.valueForKey("lopenscore")! as! String
            }
            
            if((data.valueForKey("image")) != nil){
                
                self.fotodata = data.valueForKey("image")! as! NSData
                
                if(self.fotodata != nil){
                    var convertedImage:UIImage = UIImage(data: fotodata)!;
                    self.foto = convertedImage;
                    
                    
                }
                
            }
            
        }
        
        
        if(self.balans == ""){
            println("balans badge niet behaald")
            balansNot = UIImageView(image: UIImage(named: "nonbadge"))
            balansNot.frame = CGRectMake(100, 150, 137, 123)
            self.view.addSubview(balansNot)
        }else{
            println("balans badge behaald")
            
            balansbutton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            balansbutton.frame = CGRectMake(100, 150, 137, 123)
            balansbutton.setBackgroundImage(UIImage(named: "balansbadge"), forState: UIControlState.Normal)
            balansbutton.addTarget(self, action: "buttonAction2:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(balansbutton)
        }
        
        if(self.lopen == ""){
            println("loop badge niet behaald")
            lopenNot = UIImageView(image: UIImage(named: "nonbadge"))
            lopenNot.frame = CGRectMake(20, 273, 137, 123)
            self.view.addSubview(lopenNot)
        }else{
            println("loop badge behaald")
            
            loopbutton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            loopbutton.frame = CGRectMake(20, 273, 137, 123)
            loopbutton.setBackgroundImage(UIImage(named: "badgelopen"), forState: UIControlState.Normal)
            loopbutton.addTarget(self, action: "buttonAction1:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(loopbutton)
        }
        
        if(self.foto == nil){
            println("foto badge niet behaald")
            fotoNot = UIImageView(image: UIImage(named: "nonbadge"))
            fotoNot.frame = CGRectMake(170, 273, 137, 123)
            self.view.addSubview(fotoNot)
        }else{
            println("foto badge behaald")

            
            fotobutton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            fotobutton.frame = CGRectMake(170, 273, 144, 121)
            fotobutton.setBackgroundImage(UIImage(named: "badgefoto"), forState: UIControlState.Normal)
            fotobutton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(fotobutton)
        }

        
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let imageViewBack = UIImageView(image: UIImage(named: "backbadges"))
        self.view.addSubview(imageViewBack)

        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("clicked on photo badge")
        
        let fotobadge = FotobadgeViewController()
        fotobadge.image = self.foto
        self.navigationController!.pushViewController(fotobadge, animated: true)
    }
    
    func buttonAction1(sender:UIButton!)
    {
        println("clicked on loop badge")
        
        let loopbadge = LoopbadgeViewController()
        loopbadge.score = self.lopen
        self.navigationController!.pushViewController(loopbadge, animated: true)
    }
    
    func buttonAction2(sender:UIButton!)
    {
        println("clicked on balans badge")
        let balansbadge = BalansbadgeViewController()
        balansbadge.score = self.balans
        self.navigationController!.pushViewController(balansbadge, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {

        
        super.viewDidDisappear(animated)
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
