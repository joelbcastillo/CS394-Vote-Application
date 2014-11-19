//
//  ViewController.swift
//  PopularSongsCompare
//
//  Created by Jaclyn May on 11/18/14.
//  Copyright (c) 2014 NYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myRootRef = Firebase(url:"https://popularsongscompared.firebaseio.com/")
    
    var title1:String!
    var title2:String!
    var image1:String!
    var image2:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func randomIndex() -> Int {
        return Int(arc4random_uniform(99))
    }
    func get_two_songs(){
        var randomIndex1 = randomIndex() //to add
        var randomIndex2  = randomIndex()
        while randomIndex1 == randomIndex2{
            randomIndex2 = randomIndex()
        }
        let songsURL = myRootRef.childByAppendingPath("feed/entry")
        var songURL1 = songsURL.childByAppendingPath(String(randomIndex1))
        var imageURL1 = songURL1.childByAppendingPath("link/1")
        var songURL2 = songsURL.childByAppendingPath(String(randomIndex2))
        var imageURL2 = songURL2.childByAppendingPath("link/1")

        songURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.title1  = snapshot.value["title"] as? String
            
            
        })
        
        imageURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.image1 = snapshot.value["href"] as? String

        })
        songURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.title2  = snapshot.value["title"] as? String
        
            
        })
        
        imageURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.image2 = snapshot.value["href"] as? String
            
        })
        
    }

}

