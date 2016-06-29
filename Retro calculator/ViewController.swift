//
//  ViewController.swift
//  Retro calculator
//
//  Created by Saketh D on 6/28/16.
//  Copyright © 2016 Saketh D. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
   
    
    var runningNumber = ""
    var leftVal = ""
    var rightVal = ""
    
    enum Operation: String{
        case Division = "/"
        case Multiply = "x"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    var operation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: ".wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        outputLabel.text = ""
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func pressButton(sender: UIButton!){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    @IBAction func onAddPress(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    @IBAction func OnDividePress(sender: AnyObject) {
        processOperation(Operation.Division)
    }
    @IBAction func onEqualsPress(sender: AnyObject) {
        processOperation(operation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if operation != Operation.Empty {
            if runningNumber != ""{
                rightVal = runningNumber
                runningNumber = ""
                
                if operation == Operation.Add{
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }
                else if operation == Operation.Subtract{
                    result = "\(Double(leftVal)! - Double(rightVal)!)"
                }
                else if operation == Operation.Multiply{
                    result = "\(Double(leftVal)! + Double(rightVal)!)"
                }else{
                    result = "\(Double(leftVal)! / Double(rightVal)!)"
                }
                
                leftVal = result
                outputLabel.text = result

            }
            operation = op
            
        }else{
            leftVal = runningNumber
            runningNumber = ""
            operation = op
        }
    }
    func playSound(){
        if(btnSound.playing){
            btnSound.stop()
        }
        btnSound.play()
    }
    
   
    

}

