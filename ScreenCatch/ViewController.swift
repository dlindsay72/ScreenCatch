//
//  ViewController.swift
//  ScreenCatch
//
//  Created by Dan Lindsay on 2018-02-15.
//  Copyright © 2018 Dan Lindsay. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var micSwitch: UISwitch!
    @IBOutlet weak var selectedImage: UIImageView!
    
    var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func startRecording() {
        guard recorder.isAvailable else {
            print("Recording is not available at this time")
            return
        }
        
        if micSwitch.isOn {
            recorder.isMicrophoneEnabled = true
        } else {
            recorder.isMicrophoneEnabled = false
        }
        
        recorder.startRecording { (error) in
            guard error == nil else {
                print("There was an error starting the recording")
                return
            }
            print("STARTED RECORING")
            
            DispatchQueue.main.async {
                self.micSwitch.isEnabled = false
                self.recordBtn.setTitleColor(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1), for: .normal)
                self.recordBtn.setTitle("Stop", for: .normal)
                self.statusLbl.text = "Recording..."
                self.statusLbl.textColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
                self.isRecording = true
            }
            
        }
    }
    
    func stopRecording() {
        
    }
    
    @IBAction func recordBtnWasPressed(_ sender: Any) {
        if !isRecording {
            startRecording()
        } else {
            stopRecording()
        }
    }
    
    @IBAction func imagePicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedImage.image = UIImage(named: "skate")
        case 1:
            selectedImage.image = UIImage(named: "food")
        case 2:
            selectedImage.image = UIImage(named: "cat")
        case 3:
            selectedImage.image = UIImage(named: "nature")
        default:
            selectedImage.image = UIImage(named: "skate")
        }
    }

}

