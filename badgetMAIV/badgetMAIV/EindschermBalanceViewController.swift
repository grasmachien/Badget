//
//  EindschermBalanceViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 12/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class EindschermBalanceViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var userData = [NSManagedObject]()
    var dataFromScore:Int?
    var gewonnenverloren:String?
    var username:String = "";
    var labelscore: UILabel!
    
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
        
        println(gewonnenverloren)

        // Do any additional setup after loading the view.
        
        if(self.gewonnenverloren == "verloren"){
            
            let verlorenback = UIImageView(image: UIImage(named: "verlorenpagina"))
            self.view.addSubview(verlorenback)
        }
        
        if(self.gewonnenverloren == "gewonnen"){
            
            let gewonnenback = UIImageView(image: UIImage(named: "winstabieler"))
            self.view.addSubview(gewonnenback)
            
            self.labelscore = UILabel(frame: CGRectMake(0, 0, 200, 21))
            self.labelscore.center = CGPointMake(160, 370)
            self.labelscore.textAlignment = NSTextAlignment.Center
            self.labelscore.text = "Je behaalde \(self.dataFromScore!)"
            self.labelscore.textColor = UIColor.whiteColor()
            self.view.addSubview(self.labelscore)
            
            let parameter = [
                "tijd": String(self.dataFromScore!),
                "spel": "versus",
                "username": self.username
            ]
            
            Alamofire.request(.POST, "http://student.howest.be/matthias.brodelet/20142015/MA4/BADGET/api/data", parameters: parameter)
                .responseJSON { (request, response, JSON, error) in
                    println("REQUEST \(request)")
                    println("RESPONSE \(response)")
                    println("JSON \(JSON)")
                    println("ERROR \(error)")
            }
            
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
            let score = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext!)
            
            score.setValue(String(self.dataFromScore!), forKey: "balansscore")
            
            var error:NSError?
            
            if !appDelegate.managedObjectContext!.save(&error) {
                println("could not save \(error), \(error?.userInfo)")
            }

        }
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
