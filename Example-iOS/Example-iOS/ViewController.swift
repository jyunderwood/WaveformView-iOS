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

final class ViewController: UIViewController {
    
    @IBOutlet weak var waveformView: WaveformView!
    
    var audioRecorder: AVAudioRecorder!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let recorder = getAudioRecorder(URL(fileURLWithPath:"/dev/null")) else {
            return
        }
        
        audioRecorder = recorder
        audioRecorder.record()

        let displayLink = CADisplayLink(target: self, selector: #selector(updateMeters))
        displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }

    @objc func updateMeters() {
        audioRecorder.updateMeters()
        let normalizedValue = pow(10, audioRecorder.averagePower(forChannel: 0) / 20)
        waveformView.updateWithLevel(CGFloat(normalizedValue))
    }
    
    // MARK: - Helper

    private func getAudioRecorder(_ filePath: URL) -> AVAudioRecorder? {
        let recorderSettings: [String : AnyObject] = [
            AVSampleRateKey: 44100.0 as AnyObject,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2 as AnyObject,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue as AnyObject
        ]
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord)

            let audioRecorder = try AVAudioRecorder(url: filePath,
                                                    settings: recorderSettings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            return audioRecorder
        } catch {
            let alertController = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return nil
        }
    }
}
