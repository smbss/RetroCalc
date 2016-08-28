//
//  ViewController.swift
//  21-RetroCalculatorApp
//
//  Created by Sandro Simes on 28/08/16.
//  Copyright © 2016 SandroSimes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
        // Creating the instance that will be used to play the sound
    var btnSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

            // Getting the path for the sound
        let path = Bundle.main.pathForResource("btn", ofType: "wav")
            // Converting path (String) to an url
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
                // Attaching the sound to the instance created
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
                // Anything that "throws" in the method suggestion list needs a "do catch" statement
            btnSound.prepareToPlay() // Preparing the button to play before we even use it
        } catch let err as NSError {
            print(err.debugDescription) // Printing the error in case it fails
        }
    
    }
    
        // Created the action for the pressed button (connected to each number)
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }

}
