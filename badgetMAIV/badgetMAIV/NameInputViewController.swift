//
//  NameInputViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 13/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData

class NameInputViewController: UIViewController {
    
    var myTextField:UITextField!
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageViewBackintro = UIImageView(image: UIImage(named: "naaminput"))
        self.view.addSubview(imageViewBackintro)
        
        myTextField = UITextField(frame: CGRect(x: 57, y: 235, width: 230.00, height: 40.00));
        myTextField.textColor = UIColor.whiteColor()
        myTextField.placeholder = "jouw naam"
        self.view.addSubview(myTextField)
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(230,235 , 48, 39)
        button.setBackgroundImage(UIImage(named: "textbtn"), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func buttonAction(sender:UIButton!)
    {
        var name = myTextField.text;
        
        if !name.isEmpty {
            
            
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: appDelegate.managedObjectContext!)
            let usernames = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegate.managedObjectContext!)
            
            usernames.setValue(name, forKey: "naaam")
            
            var error:NSError?
            
            if !appDelegate.managedObjectContext!.save(&error) {
                println("could not save \(error), \(error?.userInfo)")
            }
            
            self.navigationController!.pushViewController(ChallengeViewController(), animated: true)
            
            
        }else {
            
            let alert = UIAlertController(title: "Oeps", message: "Vul een naam in", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
            
        }

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
