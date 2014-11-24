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

    @IBOutlet weak var songOneLabel: UILabel!
    @IBOutlet weak var songTwoLabel: UILabel!
    @IBOutlet weak var songOneImage: UIImageView!
    @IBOutlet weak var songTwoImage: UIImageView!
    @IBOutlet weak var songOneButton: UIButton!
    @IBOutlet weak var songTwoButton: UIButton!

    var id1 = 2
    var id2 = 1
    
    var imageOneScore = 0
    var imageTwoScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get_two_songs()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SongOneButton(sender: AnyObject) {
        var votesURL = myRootRef.childByAppendingPath("feed/entry/\(String(self.id1))")
        var votes : Int? = 0
        votesURL.observeEventType(FEventType.Value, withBlock: { (snapshot) in
           votes = snapshot.value["votes"] as? Int
            println("url: " + votesURL.debugDescription)
            if (votes != nil) {
                // var votes = snapshot.value["votes"] as Int
                println("votes: " + String(votes!))
                votes = votes! + 1
                votesURL.setValue(votes!)
                println("votes changed")
            } else {
                println("votes == nil")
            }
        })
        votes = votes! + 1
        votesURL.setValue(votes)
    }
    
    @IBAction func songTwoButton(sender: AnyObject) {
        var votesURL = myRootRef.childByAppendingPath("feed/entry/\(String(self.id2))")
        var votes : Int? = 0
        votesURL.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            votes = snapshot.value["votes"] as? Int
            println("url: " + votesURL.debugDescription)
            if (votes != nil) {
                // var votes = snapshot.value["votes"] as Int
                println("votes: " + String(votes!))
                votes = votes! + 1
                votesURL.setValue(votes!)
                println("votes changed")
            } else {
                println("votes == nil")
            }
        })
        votes = votes! + 1
        votesURL.setValue(votes)
        
    }
    
    func get_two_songs(){
        self.id1 = randomIndex()
        
        do {
            self.id2 = randomIndex()
        } while self.id1 == self.id2
        
        let top100SongsURL = myRootRef.childByAppendingPath("feed/entry")
        
        var songURL1 = top100SongsURL.childByAppendingPath(String(self.id1) + "/title")
        var imageURL1 = top100SongsURL.childByAppendingPath(String(self.id1) + "/im:image/2")
        var songURL2 = top100SongsURL.childByAppendingPath(String(self.id2) + "/title")
        var imageURL2 = top100SongsURL.childByAppendingPath(String(self.id2) + "/im:image/2")


        // println("debug description" + imageURL1.debugDescription)
        
        songURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var title  = snapshot.value["label"] as? String
            if (title != nil ) {
                self.songOneLabel.text = title
            }

        })
      
        imageURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url = snapshot.value["label"] as? String
            if (url != nil) {
                let nsurl = NSURL(string: url!);
                var err: NSError?
                var imageData : NSData? = NSData(contentsOfURL: nsurl!)
                var image : UIImage? = UIImage(data:imageData!)
                self.songOneButton.setBackgroundImage(UIImage(data:imageData!), forState: UIControlState.Normal)
            }
        })
    
        songURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var title  = snapshot.value["label"] as? String
            if (title != nil ) {
                self.songTwoLabel.text = title
            }
        })
        
        imageURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url = snapshot.value["label"] as? String
            if (url != nil) {
                let nsurl = NSURL(string: url!);
                var err: NSError?
                var imageData : NSData? = NSData(contentsOfURL: nsurl!)
                var image : UIImage? = UIImage(data:imageData!)
                self.songTwoButton.setBackgroundImage(UIImage(data:imageData!), forState: UIControlState.Normal)
            }
        })
        
    }
     override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            for touch: AnyObject in touches{
                var location = touch.locationInView(self.view)
                if (location.x >= self.view.frame.size.width/2)
                {
                   ++imageOneScore
                    
                }
        }
    }
    
    func randomIndex() -> Int {
        return Int(arc4random_uniform(99))
    }
    
    func fillVotes() {
        /*
        var url : String = "feed/entry/0/votes/"
        var usersRef = myRootRef.childByAppendingPath(url)
        var value = "0"
        usersRef.setValue(value)
        */
        
        var url : String = "feed/entry/"
        for (var i = 0; i < 99;i++) {
        url += String(i)
        url += String("/votes/")
        var usersRef = myRootRef.childByAppendingPath(url)
        var value = "0"
        usersRef.setValue(value)
        url = "feed/entry/"
        }
    }


}

