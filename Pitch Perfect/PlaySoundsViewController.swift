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
    var engine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var receivedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (receivedAudio != nil){
            var error:NSError?
            player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            player.enableRate = true
            audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
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
        engine = AVAudioEngine()
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
    
    @IBAction func onChipmunkClick(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func onVaderClick(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    func playAudioWithVariablePitch(pitch: Float){
        player.stop()
        engine.stop()
        engine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        engine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        engine.attachNode(changePitchEffect)
        
        engine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        engine.connect(changePitchEffect, to: engine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        engine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
}
