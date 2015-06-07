//
//  AddNameTableViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 7/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData

protocol AddNameTableViewControllerDelegate:class {
    
    func addNameTableViewController( viewController:AddNameTableViewController, saveDateWithName name:String )
    
}



class AddNameTableViewController: UITableViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    var delegate:AddNameTableViewControllerDelegate?
    
    // MARK: - Initializers methods
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override init(style: UITableViewStyle) {
        
        super.init(style: style)
        
    }
    
    required init!(coder aDecoder: NSCoder!) {
        
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        println("voeg hier je naam in")
        
        title = "Naam invoegen"
        
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("ok", forState: UIControlState.Normal)
        button.addTarget(self, action: "saveDateHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        tableView.registerClass(TextFieldTableViewCell.classForCoder(), forCellReuseIdentifier: "formCell")


    }
    
    func saveDateHandler( sender:UIBarButtonItem ) {
        
        println("[AddDateVC] Save date handler")
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextFieldTableViewCell
        
        if let name = cell.textField?.text {
            
            if !name.isEmpty {
                
                println("[AddDateVC] The name is '\(name)'")
//                self.delegate?.addNameTableViewController(self, saveDateWithName: name)
                
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("formCell", forIndexPath: indexPath) as! TextFieldTableViewCell
        
        
        cell.textLabel?.text = "Naam"
        
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
