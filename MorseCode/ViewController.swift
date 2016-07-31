//
//  ViewController.swift
//  MorseCode
//
//  Created by Pavel Osipenko on 31/07/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var morseCodeText: UITextView!
  @IBOutlet weak var outputControl: UISegmentedControl!
  
  var playSound = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func outputTypeChanged(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
      case 0: playSound = true
      case 1: playSound = false
      default: break
    }
  }
  
  @IBAction func playMorseCode(sender: UIButton) {
    print("Beep-beep")
  }
  
}

