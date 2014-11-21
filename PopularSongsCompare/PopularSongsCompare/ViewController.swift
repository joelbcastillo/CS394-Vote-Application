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

    // TODO call random numbers
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
        var votesURL = myRootRef.childByAppendingPath("feed/entry/\(self.id1)")
        // TODO: Votes gets instantiated every time this method will be accessed
        var votes:Int = 0;
        
        votesURL.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            votes = snapshot.value["votes"] as Int
            
        })
        votes = votes + 1
        votesURL.setValue(votes)
    }
    
    @IBAction func songTwoButton(sender: AnyObject) {
        var votesURL = myRootRef.childByAppendingPath("feed/entry/\(self.id2)")
        var votes:Int = 0
        
        votesURL.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            votes = snapshot.value["votes"] as Int
            
        })
        
        votes = votes + 1
        votesURL.setValue(votes)
        
    }
    
    func get_two_songs(){
        
        var randomIndex1 : Int
        var randomIndex2 : Int
        
        randomIndex1 = randomIndex()
        
        do {
            randomIndex2 = randomIndex()
        } while randomIndex1 == randomIndex2
        
        let top100SongsURL = myRootRef.childByAppendingPath("feed/entry")
        
        var songURL1 = top100SongsURL.childByAppendingPath(String(randomIndex1) + "/title")
        var imageURL1 = songURL1.childByAppendingPath("im:image/2")
        var songURL2 = top100SongsURL.childByAppendingPath(String(randomIndex2) + "/title")
        var imageURL2 = songURL2.childByAppendingPath("im:image/2")

        println("debug description" + imageURL1.debugDescription)
        
        songURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var title  = snapshot.value["label"] as? String
            self.songOneLabel.text = title
        })
      /*
        imageURL1.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url = snapshot.value["label"] as? String
            println("url: " + url!)
            
            let nsurl = NSURL(fileURLWithPath: url!);
            var err: NSError?
            var imageData : NSData = NSData(contentsOfURL: nsurl!)!
            // !, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err!)
            self.songOneImage.image = UIImage(data:imageData)

        })
        */

        

        songURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            self.songTwoLabel.text  = snapshot.value["lable"] as? String
            var title  = snapshot.value["label"] as? String
            self.songTwoLabel.text = title
        })
        /*
        imageURL2.observeEventType(FEventType.Value, withBlock: { (snapshot) in
            var url =  snapshot.value["label"] as? String
            var img = UIImage(named: url!)
            self.songTwoImage.image = img
            
        })*/
        
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

}

