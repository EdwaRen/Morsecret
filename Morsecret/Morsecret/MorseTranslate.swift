//
//  MorseTranslate.swift
//  Morsecret
//
//  Created by Edward Ren on 2017/07/18.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import Foundation
import UIKit

class MorseTranslate {
    
    func stringIntoMorseDotsDashes(text: String) -> String {
        var lowerText = text
        var morseText : String = ""
        if (text == nil) {
            print("Desired translation element is not a text")
        } else {
            lowerText = text.lowercased()
            let charMessage = Array(lowerText.characters)
            print("lower cased textToMorse message ", lowerText)
            for i in 1...lowerText.characters.count {
                morseText += charToDotsDashes(c: charMessage[i])
            }
        }
        return morseText
    }
    
    func charToDotsDashes(c: Character) -> String{
        
        return MorseTranslate.charToMorse["c"]!
        
    }
    static let morseToChar = [
        ".-" : "a",
        "-..." :  "b",
        "-.-." :  "c",
        "-.." :  "d",
        "." :  "e",
        "..-." :  "f",
        "--." :  "g",
        "...." :  "h",
        ".." :  "i",
        ".---" :  "j",
        "-.-" :  "k",
        ".-.." :  "l",
        "--" :  "m",
        "-." :  "n",
        "---" :  "o",
        ".--." :  "p",
        "--.-" :  "q",
        ".-." :  "r",
        "..." :  "s",
        "-" :  "t",
        "..-" :  "u",
        "...-" :  "v",
        ".--" :  "w",
        "-..-" :  "x",
        "-.--" :  "y",
        "--.." :  "z",
        "-----" :  "0",
        ".----" :  "1",
        "..---" :  "2",
        "...--" :  "3",
        "....-" :  "4",
        "....." :  "5",
        "-...." :  "6",
        "--..." :  "7",
        "---.." :  "8",
        "----." :  "9", 
        ".-.-.-" :  ".", 
        "--..--" :  ",", 
        "---..." :  ":", 
        "..--.." :  "?", 
        ".----." :  "'", 
        "-....-" :  "-", 
        "-..-." :  "/", 
        "-.--.-" :  "(", 
        ".-..-." :  "\"", 
        ".--.-." :  "@", 
        "-...-" :  "="
    ];
    
    static let charToMorse = ["a": ".-",
                              //Letters
        "b": "-...",
        "c": "-.-.",
        "d": "-..",
        "e": ".",
        "f": "..-.",
        "g": "--.",
        "h": "....",
        "i": "..",
        "j": ".---",
        "k": "-.-",
        "l": ".-..",
        "m": "--",
        "n": "-.",
        "o": "---",
        "p": ".--.",
        "q": "--.-",
        "r": ".-.",
        "s": "...",
        "t": "-",
        "u": "..-",
        "v": "...-",
        "w": ".--",
        "x": "-..-",
        "y": "-.--",
        "z": "--..",
        //Numbers
        "0": "-----",
        "1": ".----",
        "2": "..---",
        "3": "...--",
        "4": "....-",
        "5": ".....",
        "6": "-....",
        "7": "--...",
        "8": "---..",
        "9": "----.",
        //Grammar
        ".": ".-.-.-",
        ",": "--..--",
        ":": "---...",
        "?": "..--..",
        "'": ".----.",
        "-": "-....-",
        "/": "-..-.",
        "(": "-.--.-",
        "\"": ".-..-.",
        "@": ".--.-.",
        "=": "-...-"
        
    ];

    
}
