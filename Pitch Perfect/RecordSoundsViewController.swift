//
//  RecordSoundsViewController
//  Pitch Perfect
//
//  Created by Mohamed Abdalla on 2014-12-04.
//  Copyright (c) 2014 Mohamed Abdalla. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var recordingText: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var audioRecording:NSURL!
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController
            as PlaySoundsViewController
        destinationVC.extra = audioRecording
        super.prepareForSegue(segue, sender: sender)
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingText.hidden = true
        stopButton.hidden = true
    }

    @IBAction func onRecord(sender: UIButton) {
        recordingText.hidden = false
        stopButton.hidden = false
        recordingButton.enabled = false
        recordSound()
    }
    
    @IBAction func onStopping(sender: UIButton) {
        recordingText.hidden = true
        recordingButton.enabled = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func recordSound(){
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        audioRecording = filePath
    }

}

