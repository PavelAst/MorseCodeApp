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
  case Space = " "
}

struct MorseCode: CustomStringConvertible {
  var code: [Sygnal]
  
  var description: String {
    var text = ""
    for sygnal in code {
      text += sygnal.rawValue
    }
    return text
  }
}

struct MorseCoder {
  
  enum Error: ErrorType {
    case InvalidCharacter(Character)
  }
  
  private static let codeSignals: [Character: MorseCode] = [
    "1": MorseCode(code: [.Dot,  .Dash, .Dash, .Dash, .Dash]),
    "2": MorseCode(code: [.Dot,  .Dot,  .Dash, .Dash, .Dash]),
    "3": MorseCode(code: [.Dot,  .Dot,  .Dot,  .Dash, .Dash]),
    "4": MorseCode(code: [.Dot,  .Dot,  .Dot,  .Dot,  .Dash]),
    "5": MorseCode(code: [.Dot,  .Dot,  .Dot,  .Dot,  .Dot]),
    "6": MorseCode(code: [.Dash, .Dot,  .Dot,  .Dot,  .Dot]),
    "7": MorseCode(code: [.Dash, .Dash, .Dot,  .Dot,  .Dot]),
    "8": MorseCode(code: [.Dash, .Dash, .Dash, .Dot,  .Dot]),
    "9": MorseCode(code: [.Dash, .Dash, .Dash, .Dash, .Dot]),
    "0": MorseCode(code: [.Dash, .Dash, .Dash, .Dash, .Dash]),
    "a": MorseCode(code: [.Dot,  .Dash]),
    "b": MorseCode(code: [.Dash, .Dot,  .Dot,  .Dot]),
    "c": MorseCode(code: [.Dash, .Dot,  .Dash, .Dot]),
    "d": MorseCode(code: [.Dash, .Dot,  .Dot]),
    "e": MorseCode(code: [.Dot]),
    "f": MorseCode(code: [.Dot,  .Dot,  .Dash, .Dot]),
    "g": MorseCode(code: [.Dash, .Dash, .Dot]),
    "h": MorseCode(code: [.Dot,  .Dot,  .Dot,  .Dot]),
    "i": MorseCode(code: [.Dot,  .Dot]),
    "j": MorseCode(code: [.Dot,  .Dash, .Dash, .Dash]),
    "k": MorseCode(code: [.Dash, .Dot,  .Dash]),
    "l": MorseCode(code: [.Dot,  .Dash, .Dot, .Dot]),
    "m": MorseCode(code: [.Dash, .Dash]),
    "n": MorseCode(code: [.Dash, .Dot]),
    "o": MorseCode(code: [.Dash, .Dash, .Dash]),
    "p": MorseCode(code: [.Dot,  .Dash, .Dash, .Dot]),
    "q": MorseCode(code: [.Dash, .Dash, .Dot,  .Dash]),
    "r": MorseCode(code: [.Dot, .Dash, .Dot]),
    "s": MorseCode(code: [.Dot,  .Dot,  .Dot]),
    "t": MorseCode(code: [.Dash]),
    "u": MorseCode(code: [.Dot,  .Dot,  .Dash]),
    "v": MorseCode(code: [.Dot, .Dot,  .Dot,  .Dash]),
    "w": MorseCode(code: [.Dot,  .Dash,  .Dash]),
    "x": MorseCode(code: [.Dash, .Dot,  .Dot,  .Dash]),
    "y": MorseCode(code: [.Dash,  .Dot,  .Dash, .Dash]),
    "z": MorseCode(code: [.Dash, .Dash, .Dot,  .Dot]),
    ".": MorseCode(code: [.Dot,  .Dash, .Dot, .Dash, .Dot, .Dash]),
    ",": MorseCode(code: [.Dash, .Dash, .Dot,  .Dot, .Dash, .Dash]),
    ":": MorseCode(code: [.Dash, .Dash, .Dash, .Dot,  .Dot, .Dot]),
    ";": MorseCode(code: [.Dash, .Dot, .Dash, .Dot,  .Dash, .Dot]),
    "?": MorseCode(code: [.Dot, .Dot,  .Dash, .Dash, .Dot, .Dot]),
    "!": MorseCode(code: [.Dash, .Dash, .Dot,  .Dot, .Dash, .Dash]),
    "'": MorseCode(code: [.Dot,  .Dash, .Dash, .Dash, .Dash, .Dot]),
    "-": MorseCode(code: [.Dash, .Dot,  .Dot, .Dot, .Dot, .Dash]),
    "/": MorseCode(code: [.Dash, .Dot, .Dot,  .Dash, .Dot]),
    "(": MorseCode(code: [.Dash, .Dot,  .Dash, .Dash, .Dot]),
    ")": MorseCode(code: [.Dash, .Dot,  .Dash, .Dash, .Dot, .Dash]),
    "\"": MorseCode(code: [.Dot,  .Dash, .Dot, .Dot, .Dash, .Dot]),
    "=": MorseCode(code: [.Dash, .Dot,  .Dot, .Dot, .Dash]),
    "+": MorseCode(code: [.Dot,  .Dash, .Dot, .Dash, .Dot]),
    "*": MorseCode(code: [.Dash, .Dot,  .Dot, .Dash]),
    "@": MorseCode(code: [.Dot,  .Dash, .Dash, .Dot, .Dash, .Dot]),
    " ": MorseCode(code: [.Space])
  ]
  
  static func encode(text text: String) throws -> String {
    var encodedString = ""
    
    for character in text.lowercaseString.characters {
      if let code = codeSignals[character] {
        encodedString += code.description
      } else {
        throw Error.InvalidCharacter(character)
      }
    }
    
    return encodedString
  }
  
}