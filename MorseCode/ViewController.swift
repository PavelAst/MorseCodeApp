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
  
  var sourceText: String? {
    didSet {
      updateMorseCodeText()
    }
  }
  
  var playSound = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    textField.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
    print("Beep-beep")
  }
  
  func updateMorseCodeText() {
    guard let source = sourceText else {
      return
    }

    if let morseCode = MorseCoder(phrase: source) {
      morseCodeText.text = morseCode.getStringRepresentation()
    } else {
      let alertController = UIAlertController(title: "Error", message: "We can't encode because this character is unknown.", preferredStyle: .Alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      presentViewController(alertController, animated: true, completion: nil)
    }
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
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

