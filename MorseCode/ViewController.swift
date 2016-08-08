//
//  ViewController.swift
//  MorseCode
//
//  Created by Pavel Osipenko on 31/07/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var morseCodeText: UITextView!
  @IBOutlet weak var outputControl: UISegmentedControl!
  @IBOutlet weak var playCodeButton: UIButton!
  
  var sourceText: String? {
    didSet {
      updateMorseCodeText()
    }
  }
  
  var oscillator = AKOscillator()
  var playSound = true
  private var timer = NSTimer()
  var binaryCode = [Bool]()
  
  var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    textField.delegate = self
    
    // Prepare AudioKit
    AudioKit.output = oscillator
    AudioKit.start()
  }
  
  @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  @IBAction func outputTypeChanged(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0: playSound = true
    case 1: playSound = false
    default: break
    }
  }
  
  @IBAction func playMorseCode(sender: UIButton) {
    textField.resignFirstResponder()
    
    if let morseCode = MorseCoder(phrase: sourceText!) {
      binaryCode = morseCode.getBinaryRepresentation()
      // print(binaryCode)
      
      if playSound {
        playCodeButton.enabled = false
        oscillator.amplitude = 0.75
        oscillator.frequency = 600
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.playSoundCode), userInfo: nil, repeats: true)
      }
    }
    
  }
  
  func updateMorseCodeText() {
    guard let source = sourceText else {
      return
    }
    
    if let morseCode = MorseCoder(phrase: source) {
      morseCodeText.text = morseCode.getStringRepresentation()
      playCodeButton.enabled = true
    } else {
      let alertController = UIAlertController(title: "Error", message: "We can't encode because this character is unknown.", preferredStyle: .Alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
  func playSoundCode() {
    guard currentIndex < binaryCode.count else {
      timer.invalidate()
      oscillator.stop()
      currentIndex = 0
      playCodeButton.enabled = true
      return
    }
    if binaryCode[currentIndex] {
      oscillator.start()
    } else {
      oscillator.stop()
    }
    currentIndex += 1
  }
  
  func showLightsCode() {
    
  }
  
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    // Figure out what the new text will be, if we return true
    var newText: NSString = textField.text!
    newText = newText.stringByReplacingCharactersInRange(range, withString: string)
    
    sourceText = newText as String
    
    // returning true gives the text field permission to change its text
    return newText.length <= 40;
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    textField.backgroundColor = UIColor.init(red: 222.0/255.0, green: 242.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    textField.backgroundColor = UIColor.whiteColor()
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    sourceText = ""
    playCodeButton.enabled = false
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

