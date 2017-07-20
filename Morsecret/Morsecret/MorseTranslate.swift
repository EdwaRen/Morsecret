//
//  MorseTranslate.swift
//  Morsecret
//
//  Created by Edward Ren on 2017/07/18.
//  Copyright © 2017 Secretapp. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer
import AudioToolbox



class MorseTranslate {
    var timer : Timer!
    var counter: Int = 0;
    


    
    func timerMorseToVibrations(text: String) {
//        let charMorse = Array(text.characters)
//        print(charMorse, " char morse")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MorseTranslate.charMorseToVibration(c:)), userInfo: text, repeats: false)

//        for i in 0...text.characters.count-1 {
//            print(charMorse[i])
//            timer = Timer.scheduledTimer(timeInterval: TimeInterval(i+1), target: self, selector: #selector(MorseTranslate.charMorseToVibration(c:)), userInfo: text, repeats: false)
//        }
        
    }
    func AudioServicesPlaySystemSoundWithVibration(_: Int , _: ExpressibleByNilLiteral, _: NSDictionary){};


    
    @objc func charMorseToVibration(c: Timer) {

        let k = timer.userInfo as! String
        let i = Array(k.characters)
        print(i[counter])
        var timeBetweenVibrate: Double = 0.8
        if (i[counter] == ".") {
            print("dot")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
        } else if (i[counter] == "-") {
            print("dash")
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));
            let myTim = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(MorseTranslate.playAlertAgain), userInfo: nil, repeats: false)
            timeBetweenVibrate += 0.4

        } else if (i[counter] == " ") {
            print("Space detected")
        } else {
            print("ERROR: Morse string to vibration char is unreadable", i)
        }
        counter += 1
        if (counter < k.characters.count) {
            timer = Timer.scheduledTimer(timeInterval: timeBetweenVibrate, target: self, selector: #selector(MorseTranslate.charMorseToVibration(c:)), userInfo: k, repeats: false)
        }

    }

    
    @objc func playAlertAgain() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate));

    }
    
    func stringIntoMorseDotsDashes(text: String) -> String {
        var lowerText = text
        var morseText : String = ""
        if (text == "") {
            print("Desired translation element is not a text")
        } else {
            lowerText = text.lowercased()
            let charMessage = Array(lowerText.characters)
            print("lower cased textToMorse message ", lowerText)
            for i in 0...lowerText.characters.count-1 {
                morseText += MorseTranslate.charToMorse[String(charMessage[i])]!
                morseText += " "

            }
        }
        print(morseText)
        return morseText
    }
    
  
    
    func morseIntoString(text: String) -> String {
        
        return text
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
        "=": "-...-",
        " ": " "
        
    ];

    
}
