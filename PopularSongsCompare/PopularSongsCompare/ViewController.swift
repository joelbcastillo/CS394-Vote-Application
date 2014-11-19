//
//  ViewController.swift
//  PopularSongsCompare
//
//  Created by Jaclyn May on 11/18/14.
//  Copyright (c) 2014 NYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myRootRef = Firebase(url:"https://popularsongscompared.firebaseio.com/")
    
    func randomIndex() -> Int {
        return Int(arc4random_uniform(99))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        println(randomIndex())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

