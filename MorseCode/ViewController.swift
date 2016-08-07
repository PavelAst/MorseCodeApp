//
//  ViewController.swift
//  MorseCode
//
//  Created by Pavel Osipenko on 31/07/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit
import AVFoundation

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
  
  var audioPlayer: AVAudioPlayer?
  var playSound = true
  private var timer = NSTimer()
  var binaryCode = [Bool]()
  
  var currentIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    textField.delegate = self
    
    // initialize the audioPlayer
    audioPlayer = setupAudioPlayer()
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
    textField.resignFirstResponder()
    
    if let morseCode = MorseCoder(phrase: sourceText!) {
      binaryCode = morseCode.getBinaryRepresentation()
      // print(binaryCode)
      currentIndex = 0
      
      timer = NSTimer.scheduledTimerWithTimeInterval(0.08, target: self, selector: #selector(ViewController.playSoundCode), userInfo: nil, repeats: true)

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
  
  func setupAudioPlayer() -> AVAudioPlayer? {
    var audioPlayer: AVAudioPlayer?
    let audioFile = "beep080.wav"
    let url = NSBundle.mainBundle().URLForResource(audioFile, withExtension: nil)
    if (url == nil) {
      print("Could not find file: \(audioFile)")
      return nil
    }
    do {
      audioPlayer = try AVAudioPlayer(contentsOfURL: url!)
    } catch let error as NSError {
      print("audioPlayer error - \(error.localizedDescription)")
      audioPlayer = nil
    }
    return audioPlayer
  }
  
  func playSoundCode() {
    guard currentIndex < binaryCode.count else {
      timer.invalidate()
      return
    }
    if binaryCode[currentIndex] {
      if let player = audioPlayer {
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.currentTime = 0.0
        player.play()
      }
    }
    currentIndex += 1
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

