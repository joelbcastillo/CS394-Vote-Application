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
    
    @IBOutlet weak var title1: UILabel!
    
    @IBOutlet weak var title2: UILabel!

    @IBOutlet weak var image1: UIImageView!

    @IBOutlet weak var image2: UIImageView!
    
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
            self.title1.text  = snapshot.value["title"] as? String
            
            
        })
        
        imageURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url = snapshot.value["href"] as? String
            var imagez = UIImage(named: url!)
            self.image1.image = imagez

        })
        songURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.title2.text  = snapshot.value["title"] as? String
        
            
        })
        
        imageURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url =  snapshot.value["href"] as? String
            var img = UIImage(named: url!)
            self.image2.image = img
            
        })
        
    }

}

