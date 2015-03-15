//
//  ViewController.swift
//  SiriWaveformDemo
//
//  Created by Jonathan on 3/14/15.
//  Copyright (c) 2015 Jonathan Underwood. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var waveformView: SiriWaveformView!
    private var recorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(fileURLWithPath:"/dev/null")
        let recorderSettings = [
            AVSampleRateKey: 44100.0,
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue
        ]

        recorder = AVAudioRecorder(URL: url, settings: recorderSettings, error: nil)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)

        recorder.prepareToRecord()
        recorder.meteringEnabled = true
        recorder.record()

        var displayLink = CADisplayLink(target: self, selector: Selector("updateMeters"))
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    func updateMeters() {
        recorder.updateMeters()
        var normalizedValue = pow(10, recorder.averagePowerForChannel(0) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }
}
