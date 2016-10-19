//
//  ViewController.swift
//  21-RetroCalculatorApp
//
//  Created by smbss on 28/08/16.
//  Copyright © 2016 smbss. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
        // Creating the label to display the result
    @IBOutlet weak var outputLbl: UILabel!
    
        // Creating the instance that will be used to play the sound
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide
        case Multiply
        case Subtract
        case Add
        case Empty
    }
    
        // Initially there will be no current operation
    var currentOperation = Operation.Empty
        // The string that will be used to save the current number
    var runningNumber = ""
        // Vars used to split the string on left and right side of the operator
    var leftValStr = ""
    var rightValStr = ""
        // String used to display the result
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()

            // Getting the path for the sound
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
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
        
            // Setting the innitial string to 0
        outputLbl.text = "0"
    }
    
        // Created the action for the pressed button (connected to each number)
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
            // Cleaning the result for a new calc if the input is not an operator
        if result != "" && currentOperation == .Empty {
            clear()
        }
        
            // Building the string that displays the current number
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        decideToContinue(operation: .Divide)
    }
    
    @IBAction func onMultiply(sender: AnyObject) {
        playSound()
        decideToContinue(operation: .Multiply)
    }
    
    @IBAction func onSubtractionPressed(sender: AnyObject) {
        playSound()
        decideToContinue(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        decideToContinue(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        playSound()
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clear(sender: AnyObject) {
        clear()
    }
    
    func decideToContinue(operation: Operation) {
        if result != "" {
                // If there is already a result continue the operation
            currentOperation = operation
        } else {
            processOperation(operation: operation)
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            
                // Verifying that the runningNumber has a value and resetting it
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if leftValStr != "" && rightValStr != "" {
                    // Converting the strings to doubles and doing the operation for each case
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                outputLbl.text = result
                    // Passing the result to leftValStr in case the operation continues
                leftValStr = result
                }
            }
            currentOperation = .Empty
        } else {
                // This happens when operators are selected twice without number input
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func clear() {
        outputLbl.text = "0"
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
    }
}
