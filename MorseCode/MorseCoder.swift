//
//  MorseCoder.swift
//  MorseCode
//
//  Created by Pavel Osipenko on 02/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import Foundation

enum Sygnal: String {
  case Dot   = "."
  case Dash  = "-"
  case Space = "   "
}

struct MorseSymbol: CustomStringConvertible {
  var code: [Sygnal]
  
  var description: String {
    var text = ""
    for sygnal in code {
      text += sygnal.rawValue
    }
    return text
  }
  
  func getBinaryCode() -> [Bool] {
    if code == [.Space] {
      return [false]
    }
    var binary = [Bool]()
    for (index, sygnal) in code.enumerated() {
      if sygnal == .Dot {
        binary += [true]
      } else if sygnal == .Dash {
        binary += [true, true, true]
      }
      if index != (code.endIndex - 1) {
        binary += [false]
      }
    }
    return binary
  }
}

struct MorseCoder {
  
  fileprivate let codeSignals: [Character: MorseSymbol] = [
    "1": MorseSymbol(code: [.Dot,  .Dash, .Dash, .Dash, .Dash]),
    "2": MorseSymbol(code: [.Dot,  .Dot,  .Dash, .Dash, .Dash]),
    "3": MorseSymbol(code: [.Dot,  .Dot,  .Dot,  .Dash, .Dash]),
    "4": MorseSymbol(code: [.Dot,  .Dot,  .Dot,  .Dot,  .Dash]),
    "5": MorseSymbol(code: [.Dot,  .Dot,  .Dot,  .Dot,  .Dot]),
    "6": MorseSymbol(code: [.Dash, .Dot,  .Dot,  .Dot,  .Dot]),
    "7": MorseSymbol(code: [.Dash, .Dash, .Dot,  .Dot,  .Dot]),
    "8": MorseSymbol(code: [.Dash, .Dash, .Dash, .Dot,  .Dot]),
    "9": MorseSymbol(code: [.Dash, .Dash, .Dash, .Dash, .Dot]),
    "0": MorseSymbol(code: [.Dash, .Dash, .Dash, .Dash, .Dash]),
    "a": MorseSymbol(code: [.Dot,  .Dash]),
    "b": MorseSymbol(code: [.Dash, .Dot,  .Dot,  .Dot]),
    "c": MorseSymbol(code: [.Dash, .Dot,  .Dash, .Dot]),
    "d": MorseSymbol(code: [.Dash, .Dot,  .Dot]),
    "e": MorseSymbol(code: [.Dot]),
    "f": MorseSymbol(code: [.Dot,  .Dot,  .Dash, .Dot]),
    "g": MorseSymbol(code: [.Dash, .Dash, .Dot]),
    "h": MorseSymbol(code: [.Dot,  .Dot,  .Dot,  .Dot]),
    "i": MorseSymbol(code: [.Dot,  .Dot]),
    "j": MorseSymbol(code: [.Dot,  .Dash, .Dash, .Dash]),
    "k": MorseSymbol(code: [.Dash, .Dot,  .Dash]),
    "l": MorseSymbol(code: [.Dot,  .Dash, .Dot, .Dot]),
    "m": MorseSymbol(code: [.Dash, .Dash]),
    "n": MorseSymbol(code: [.Dash, .Dot]),
    "o": MorseSymbol(code: [.Dash, .Dash, .Dash]),
    "p": MorseSymbol(code: [.Dot,  .Dash, .Dash, .Dot]),
    "q": MorseSymbol(code: [.Dash, .Dash, .Dot,  .Dash]),
    "r": MorseSymbol(code: [.Dot, .Dash, .Dot]),
    "s": MorseSymbol(code: [.Dot,  .Dot,  .Dot]),
    "t": MorseSymbol(code: [.Dash]),
    "u": MorseSymbol(code: [.Dot,  .Dot,  .Dash]),
    "v": MorseSymbol(code: [.Dot, .Dot,  .Dot,  .Dash]),
    "w": MorseSymbol(code: [.Dot,  .Dash,  .Dash]),
    "x": MorseSymbol(code: [.Dash, .Dot,  .Dot,  .Dash]),
    "y": MorseSymbol(code: [.Dash,  .Dot,  .Dash, .Dash]),
    "z": MorseSymbol(code: [.Dash, .Dash, .Dot,  .Dot]),
    ".": MorseSymbol(code: [.Dot,  .Dash, .Dot, .Dash, .Dot, .Dash]),
    ",": MorseSymbol(code: [.Dash, .Dash, .Dot,  .Dot, .Dash, .Dash]),
    ":": MorseSymbol(code: [.Dash, .Dash, .Dash, .Dot,  .Dot, .Dot]),
    ";": MorseSymbol(code: [.Dash, .Dot, .Dash, .Dot,  .Dash, .Dot]),
    "?": MorseSymbol(code: [.Dot, .Dot,  .Dash, .Dash, .Dot, .Dot]),
    "!": MorseSymbol(code: [.Dash, .Dash, .Dot,  .Dot, .Dash, .Dash]),
    "'": MorseSymbol(code: [.Dot,  .Dash, .Dash, .Dash, .Dash, .Dot]),
    "-": MorseSymbol(code: [.Dash, .Dot,  .Dot, .Dot, .Dot, .Dash]),
    "/": MorseSymbol(code: [.Dash, .Dot, .Dot,  .Dash, .Dot]),
    "(": MorseSymbol(code: [.Dash, .Dot,  .Dash, .Dash, .Dot]),
    ")": MorseSymbol(code: [.Dash, .Dot,  .Dash, .Dash, .Dot, .Dash]),
    "\"": MorseSymbol(code: [.Dot,  .Dash, .Dot, .Dot, .Dash, .Dot]),
    "=": MorseSymbol(code: [.Dash, .Dot,  .Dot, .Dot, .Dash]),
    "+": MorseSymbol(code: [.Dot,  .Dash, .Dot, .Dash, .Dot]),
    "*": MorseSymbol(code: [.Dash, .Dot,  .Dot, .Dash]),
    "@": MorseSymbol(code: [.Dot,  .Dash, .Dash, .Dot, .Dash, .Dot]),
    " ": MorseSymbol(code: [.Space])
  ]
  
  var morseSequence = [MorseSymbol]()
  
  init? (phrase: String) {
    for character in phrase.lowercased().characters {
      if let code = codeSignals[character] {
        morseSequence.append(code)
      } else {
        return nil
      }
    }
  }
  
  func getStringRepresentation() -> String {
    return morseSequence.reduce("") { all, current in
      all + "\(current.description) "
    }
  }
  
  func getBinaryRepresentation() -> [Bool] {
    var binaryList = [Bool]()
    for (index, symbol) in morseSequence.enumerated() {
      binaryList += symbol.getBinaryCode()
      if index != (morseSequence.endIndex - 1) {
        binaryList += [false, false, false]
      }
    }
    return binaryList
  }
  
}
