//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Mohamed Abdalla on 2014-12-04.
//  Copyright (c) 2014 Mohamed Abdalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingText.hidden = true
        stopButton.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRecord(sender: UIButton) {
        recordingText.hidden = false
        stopButton.hidden = false
    }
    @IBAction func onTop(sender: UIButton) {
        recordingText.hidden = true
    }

}

