//
//  ChallengeViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 1/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit
import CoreData

class ChallengeViewController: UIViewController, UINavigationControllerDelegate {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }

    var username = [NSManagedObject]()
    var button:UIButton!
    var button2:UIButton!
    var button3:UIButton!
    var timerr = NSTimer()
    var timerrr = NSTimer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){

        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        let sortNameAscending = NSSortDescriptor(key: "naaam", ascending: true)
        fetchRequest.sortDescriptors = [sortNameAscending]
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var error:NSError?
        username = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        
        
    
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "Challenges"
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
         super.viewDidLoad()
        
        let imageViewBack = UIImageView(image: UIImage(named: "infoBack"))
        self.view.addSubview(imageViewBack)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        if(username.isEmpty){
            println("geen naam ingevoerd")
            self.navigationController!.pushViewController(NameInputViewController(), animated: true)
            
            
        }else{
            println("je naam is \(username)")
            
        }
        
        //BUTTON CHALLENGE 1
        button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(0, 0, 320, 173)
        button.setBackgroundImage(UIImage(named: "challenge1btn"), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.alpha = 0;
        self.view.addSubview(button)
        
        //BUTTON CHALLENGE 2
        button2 = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button2.frame = CGRectMake(0, 173, 320,173)
        button2.setBackgroundImage(UIImage(named: "challenge2Btn"), forState: UIControlState.Normal)
        button2.addTarget(self, action: "buttonAction2:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.alpha = 0;
        self.view.addSubview(button2)
        
        //BUTTON CHALLENGE 3
        button3 = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button3.frame = CGRectMake(0, 346, 320, 173)
        button3.setBackgroundImage(UIImage(named: "challenge3Btn"), forState: UIControlState.Normal)
        button3.addTarget(self, action: "buttonAction3:", forControlEvents: UIControlEvents.TouchUpInside)
        button3.alpha = 0;
        self.view.addSubview(button3)
        
        self.view.backgroundColor = UIColor.blueColor()
       
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.5, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            
            self.button.alpha = 1
            
        })
        
        self.timerr = NSTimer.schedule(repeatInterval: 0.2) { timer in
        
            UIView.animateWithDuration(0.5, animations: {
                self.button2.alpha = 1
                self.timerr.invalidate()
            })
        }
        
        self.timerrr = NSTimer.schedule(repeatInterval: 0.4) { timer in
            
            UIView.animateWithDuration(0.5, animations: {
                self.button3.alpha = 1
                self.timerrr.invalidate()
            })
        }
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.button.alpha = 0
        self.button2.alpha = 0
        self.button3.alpha = 0
        
        super.viewDidDisappear(animated)
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.navigationController!.pushViewController(LoopViewController(), animated: true)
    }
    
    func buttonAction2(sender:UIButton!)
    {
        self.navigationController!.pushViewController(FotoViewController(), animated: true)
        
    }
    
    func buttonAction3(sender:UIButton!)
    {
        self.navigationController!.pushViewController(GameViewController(), animated: true)
        
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
