//
//  ViewController.swift
//  Example-iOS
//
//  Created by Jonathan on 9/4/16.
//  Copyright © 2016 Jonathan Underwood. All rights reserved.
//

import UIKit
import AVFoundation
import WaveformView

class ViewController: UIViewController {
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var waveformView: WaveformView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        audioRecorder = audioRecorder(URL(fileURLWithPath:"/dev/null"))
        audioRecorder.record()

        let displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }

    func updateMeters() {
        audioRecorder.updateMeters()
        let normalizedValue = pow(10, audioRecorder.averagePower(forChannel: 0) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }

    func audioRecorder(_ filePath: URL) -> AVAudioRecorder {
        let recorderSettings: [String : AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]

        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)

        let audioRecorder = try! AVAudioRecorder(url: filePath, settings: recorderSettings)
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()

        return audioRecorder
    }
}
