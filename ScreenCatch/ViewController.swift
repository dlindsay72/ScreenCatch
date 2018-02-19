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
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var micSwitch: UISwitch!
    @IBOutlet weak var selectedImage: UIImageView!
    
    //MARK: - Properties
    var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    //MARK: - Class Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Custom Methods
    
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
        recorder.stopRecording { (preview, error) in
            guard preview != nil else {
                print("Preview controller is not available")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording?", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.recorder.discardRecording {
                    print("recording successfully discarded")
                }
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                preview?.previewControllerDelegate = self
                if let unwrappedPreview = preview {
                    unwrappedPreview.modalPresentationStyle = .popover
                    unwrappedPreview.popoverPresentationController?.sourceView = self.view
                    unwrappedPreview.preferredContentSize = CGSize(width: self.view.bounds.width / 1.2, height: self.view.bounds.height / 1.2)
                    unwrappedPreview.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX - 50, y: self.view.bounds.midY - 50, width: 100, height: 100)
                    self.present(unwrappedPreview, animated: true, completion: nil)
                    print("Entered edit mode")
                }
            })
            
            alert.addAction(deleteAction)
            alert.addAction(editAction)
            
            self.present(alert, animated: true, completion: nil)
            self.isRecording = false
            self.viewReset()
        }
    }
    
    func viewReset() {
        micSwitch.isEnabled = true
        statusLbl.text = "Ready to Record"
        statusLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        recordBtn.setTitle("Record", for: .normal)
        recordBtn.setTitleColor(#colorLiteral(red: 0.1824951172, green: 0.7013234529, blue: 0.3100431561, alpha: 1), for: .normal)
    }
    
    ///MARK: - IBActions
    
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

//MARK: - RPPreviewViewControllerDelegate

extension ViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

