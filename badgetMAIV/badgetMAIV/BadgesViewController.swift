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
    var foto:String = "";
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
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
                self.foto = data.valueForKey("image")! as! String
            }
            
        }
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.tabBarItem = UITabBarItem(title: "badges", image: UIImage(named: "badgeIcon"), tag: 2)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.balans == ""){
            println("balans badge niet behaald")
        }else{
            println("balans badge behaald")
        }
        
        if(self.lopen == ""){
            println("loop badge niet behaald")
        }else{
            println("loop badge behaald")
        }
        
        if(self.foto == ""){
            println("foto badge niet behaald")
        }else{
            println("foto badge behaald")
        }
        
        let imageViewBack = UIImageView(image: UIImage(named: "backbadges"))
        self.view.addSubview(imageViewBack)

        // Do any additional setup after loading the view.
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
