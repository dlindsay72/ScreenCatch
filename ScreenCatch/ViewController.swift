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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func recordBtnWasPressed(_ sender: Any) {
        
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

