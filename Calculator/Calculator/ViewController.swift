//
//  ViewController.swift
//  Calculator
//
//  Created by Solutions on 28/3/17.
//  Copyright © 2017 Blank. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputField: UITextField!
    let prop = Bundle.main
    
    var opStack = NSMutableArray()
    var numStack = NSMutableArray()
    
    var textFieldShudClear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.inputField.delegate = self
        self.inputField.frame.size.height = 55
    }
    
    @IBAction func oneButton(_ sender: AnyObject) {
        self.checkValue()
        switch sender.tag {
        case 99,98,97,96:
            opStack.add(sender.tag)
            self.textFieldShudClear = true
            break
        default:
            let value = charValueOfTag(sender.tag)
            self.textFieldShudClear = false
            self.inputField.text?.append(value)
            break
        }
    }
    
    @IBAction func resultButton(_ sender: AnyObject) {

        numStack.add(Int(self.inputField.text!)!)
        
        let ops = [96,97,98,99]
        for op in ops {
            var i = 0
            while(i < opStack.count){
                if(opStack.object(at: i) as! Int == op){
                    doOperation(op, index: i, stack: numStack)
                    opStack.removeObject(at: i)
                    i = i-1
                }
                i = i+1
            }
        }
        self.inputField.text = String(describing: numStack.object(at: 0))
    }
    
    func doOperation(_ op: Int, index: Int, stack: NSMutableArray){
        switch op {
        case 96:
            divide(index, array: stack)
            break
        case 97:
            multiply(index, array: stack)
            break
        case 98:
            subtract(index, array: stack)
            break
        case 99:
            add(index, array: stack)
            break
        default:
            break
        }
    }
    
    func divide(_ index: Int, array: NSMutableArray){
        let num1 = numStack.object(at: index) as! Int
        let num2 = numStack.object(at: index+1) as! Int
        
        numStack.replaceObject(at: index, with: (num1/num2))
        numStack.removeObject(at: index+1)
    }
    
    func multiply(_ index: Int, array: NSMutableArray){
        let num1 = numStack.object(at: index) as! Int
        let num2 = numStack.object(at: index+1) as! Int
        
        numStack.replaceObject(at: index, with: (num1*num2))
        numStack.removeObject(at: index+1)
    }
    
    func subtract(_ index: Int, array: NSMutableArray){
        let num1 = numStack.object(at: index) as! Int
        let num2 = numStack.object(at: index+1) as! Int
        
        numStack.replaceObject(at: index, with: (num1-num2))
        numStack.removeObject(at: index+1)
    }
    
    func add(_ index: Int, array: NSMutableArray){
        let num1 = numStack.object(at: index) as! Int
        let num2 = numStack.object(at: index+1) as! Int
        
        numStack.replaceObject(at: index, with: (num1+num2))
        numStack.removeObject(at: index+1)
    }
    
    func charValueOfTag(_ tagVal: Int) -> Character {
        let map = prop.object(forInfoDictionaryKey: "TagMap") as! Dictionary<String,String>
        
        if let value = map[String(tagVal)] {
            return Character(value)
        } else {
            return Character(" ")
        }
    }
    
    func checkValue(){
        if(self.inputField.hasText && self.textFieldShudClear){
            numStack.add(Int(self.inputField.text!)!)
            self.inputField.text = ""
        }
    }
}

