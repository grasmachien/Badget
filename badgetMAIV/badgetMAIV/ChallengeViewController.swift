//
//  ChallengeViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 1/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit


class ChallengeViewController: UIViewController, UINavigationControllerDelegate {
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.title = "Challenges"
        println("challenge view")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
         super.viewDidLoad()
        
        //BUTTON CHALLENGE 1
        let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("foto", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        //BUTTON CHALLENGE 2
        let button2   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button2.frame = CGRectMake(100, 200, 100, 50)
        button2.backgroundColor = UIColor.greenColor()
        button2.setTitle("game", forState: UIControlState.Normal)
        button2.addTarget(self, action: "buttonAction2:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button2)
        
        //BUTTON CHALLENGE 3
        let button3   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button3.frame = CGRectMake(100, 300, 100, 50)
        button3.backgroundColor = UIColor.greenColor()
        button3.setTitle("lopen", forState: UIControlState.Normal)
        button3.addTarget(self, action: "buttonAction3:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button3)
        
        self.view.backgroundColor = UIColor.blueColor()
       
        
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.navigationController!.pushViewController(FotoViewController(), animated: true)
    }
    
    func buttonAction2(sender:UIButton!)
    {
        self.navigationController!.pushViewController(GameViewController(), animated: true)
    }
    
    func buttonAction3(sender:UIButton!)
    {
        self.navigationController!.pushViewController(LoopViewController(), animated: true)
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
