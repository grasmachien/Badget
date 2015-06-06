//
//  ViewController.swift
//  badgetMAIV
//
//  Created by Matthias Brodelet on 1/06/15.
//  Copyright (c) 2015 Brodelet.Matthias. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        self.tabBarItem = UITabBarItem(title: "list", image: UIImage(named: "list-icon"), tag: 2)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView(){
        
        var bounds = UIScreen.mainScreen().bounds;
        self.view = InfoSliderView(frame:bounds);
    }
    
    


}

