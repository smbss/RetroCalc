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
    
        // Creating the label to display the result
    @IBOutlet weak var outputLbl: UILabel!
    
        // Creating the instance that will be used to play the sound
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
        // Initially there will be no current operation
    var currentOperation = Operation.Empty
        // The string that will be used to save the current number
    var runningNumber = ""
        // Splitting the string with the left and right side of the operator
    var leftValStr = ""
    var rightValStr = ""
        // String used to display the result
    var result = ""

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
        
        outputLbl.text = "0"
    }
    
        // Created the action for the pressed button (connected to each number)
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        if result != "" && currentOperation == .Empty {
            clear()
        }
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        playSound()
        if result != "" {
            currentOperation = .Divide
        } else {
            processOperation(operation: .Divide)
        }
    }
    
    @IBAction func onMultiply(sender: AnyObject) {
        playSound()
        if result != "" {
            currentOperation = .Multiply
        } else {
            processOperation(operation: .Multiply)
        }
    }
    
    @IBAction func onSubtractionPressed(sender: AnyObject) {
        playSound()
        if result != "" {
            currentOperation = .Subtract
        } else {
            processOperation(operation: .Subtract)
        }
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        playSound()
        if result != "" {
            currentOperation = .Add
        } else {
            processOperation(operation: .Add)
        }
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        playSound()
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clear(sender: AnyObject) {
        clear()
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
            // If an operation selected do this:
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator without first entering a number
            
                // Verifying that the runningNumber has a value and resetting it
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
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
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = .Empty
        } else {
            // This is the first time an operator has been pressed
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
