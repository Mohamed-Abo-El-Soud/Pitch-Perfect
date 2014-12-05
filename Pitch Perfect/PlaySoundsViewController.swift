//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mohamed Abo El Soud on 2014-12-05.
//  Copyright (c) 2014 Mohamed Abdalla. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player = AVAudioPlayer()
    
    var extra:NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (extra != nil){
            var error:NSError?
            player = AVAudioPlayer(contentsOfURL: extra, error: nil)
            player.enableRate = true
        }
        else if var path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        {
            var sound = NSURL.fileURLWithPath(path)
            var error:NSError?
            player = AVAudioPlayer(contentsOfURL: sound, error: nil)
            player.enableRate = true
            
        } else{
            println("filepath is empty")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSnailClick(sender: UIButton) {
        player.rate = 0.5
        player.prepareToPlay()
        player.play()
    }

    @IBAction func onRabbitClick(sender: UIButton) {
        player.rate = 1.5
        player.prepareToPlay()
        player.play()
    }
    
    @IBAction func onStop(sender: UIButton) {
        if player.playing{
            player.stop()
            player.currentTime = 0.0
        }
    }
    
}
