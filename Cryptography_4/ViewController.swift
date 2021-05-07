//
//  ViewController.swift
//  Cryptography_4
//
//  Created by Admin on 07.05.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var encryptButton: UIButton!
    
    var result: [UInt8]?
    var pattern: [UInt8]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        encryptButton.layer.cornerRadius = 12
        
    }

    @IBAction func encryptAction(_ sender: Any) {
        if let text = inputTextView.text {
            let coder = LFSR()
            (pattern, result) = coder.encrypt(message: text)
            updateOuputView()
        }

        
    }
    
    @IBAction func controlAction(_ sender: UISegmentedControl) {
        updateOuputView()
    }
    
    func updateOuputView(){
        switch segmentControl.selectedSegmentIndex{
        case 0:
            if let result = result {
                outputTextView.text = result.description
            }
        case 1:
            if let pattern = pattern {
                outputTextView.text = pattern.description
            }
        default:
            if let result = result {
                let coder = LFSR()
                let decryptedString = coder.decrypt(cypher: result)
                outputTextView.text = decryptedString
            }
        }
    }
}


