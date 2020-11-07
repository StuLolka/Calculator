//
//  StartViewController.swift
//  Calculator
//
//  Created by Сэнди Белка on 06.11.2020.
//

import UIKit

final class StartViewController: UIViewController {

    @IBOutlet weak var enter: UILabel!
    @IBOutlet weak var acOUt: UIButton!
    private var result = 0.0
    private var negative = false
    private var isAct = false
    private var isActPlus = false
    private var isActMinus = false
    private var isActDevide = false
    private var isActMultiply = false
    private var isSecondEnter = false
    private var isItFraction = false
    private var instance = ""
    private var firstEnter = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        enter.text = "0"
    }
    
    @IBAction func aC(_ sender: UIButton) {
        acOUt.setTitle("AC", for: .normal)
        enter.text = "0"
        instance = ""
        result = 0.0
        negative = false
        isAct = false
        isActPlus = false
        isActMinus = false
        isActDevide = false
        isActMultiply = false
        isSecondEnter = false
        isItFraction = false
    }
    
    @IBAction func plusOrMinus(_ sender: UIButton) {
        negative = !negative
    }
    
    @IBAction func procent(_ sender: UIButton) {
        print("result1 = \(result)")
        result /= 100
        print("result2 = \(result)")
        isAct = true
        output()
        instance = String(result)
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        isAct = true
        isActMultiply = true
        isItFraction = false
    }

    @IBAction func devide(_ sender: UIButton) {
        isAct = true
        isActDevide = true
        isItFraction = false
    }
    
    @IBAction func plus(_ sender: UIButton) {
        isAct = true
        isActPlus = true
        isItFraction = false
    }
    
    @IBAction func minus(_ sender: UIButton) {
        isAct = true
        isActMinus = true
        isItFraction = false
    }
    
    @IBAction func nine(_ sender: UIButton) {
        writeNumber(9)
    }
    
    @IBAction func eight(_ sender: UIButton) {
        writeNumber(8)
    }
    
    @IBAction func seven(_ sender: UIButton) {
        writeNumber(7)
    }
    
    @IBAction func six(_ sender: UIButton) {
        writeNumber(6)
    }
    
    @IBAction func five(_ sender: UIButton) {
        writeNumber(5)
    }

    @IBAction func four(_ sender: UIButton) {
        writeNumber(4)
    }
    
    @IBAction func three(_ sender: UIButton) {
        writeNumber(3)
    }
    
    @IBAction func two(_ sender: UIButton) {
        writeNumber(2)
    }
    
    @IBAction func one(_ sender: UIButton) {
        writeNumber(1)
    }
    
    @IBAction func zero(_ sender: UIButton) {
        if enter.text != "0" {
            writeNumber(0)
        }
    }
    
    @IBAction func fractionalPart(_ sender: UIButton) {
        
        guard let _ = enter.text else {return }
        if !isItFraction {
            isItFraction = true
            enter.text! += "."
        }
        
//        else if isAct {
//            isItFraction = true
//            enter.text = "0."
//        }
//        MARK: - more
        
//        else if isItFraction && enter.text!.last == "." {
//            isItFraction = false
//            enter.text!.removeLast()
//        }

        
    }
    
    @IBAction func equally(_ sender: UIButton) {
        isAct = true
        if isSecondEnter == true {
            if let second = enter.text {
                if let secondDouble = Double(second) {
                    isSecondEnter = false
                    doIt(second: secondDouble)
                }
            }
        }
    }
    
    private func writeNumber(_ num: Int) {
        guard instance.count <= 9 else {return }
        
        if isAct == true {
            firstEnter = result
            enter.text = ""
            isSecondEnter = true
            isAct = false
        }
        
        acOUt.setTitle("C", for: .normal)
        let numStr = String(num)
        
        if isAct == false && enter.text != "0" {
            guard let _ = enter.text else {return }
            enter.text! += numStr
        }
        else {
            enter.text = numStr
        }
        
        instance += numStr
        result = Double(enter.text!) ?? 0
    }
    
    private func doIt(second num: Double) {
        
        if isActPlus {
            result = firstEnter + num
        }
        else if isActMinus {
            result = firstEnter - num
        }
        else if isActMultiply {
            result = firstEnter * num
        }
        else if isActDevide {
            if num != 0 {
                result = firstEnter / num
            }
        }
        
        if num != 0 {
            output()
        }
        else {
            enter.text = "Ошибка"
        }
        offAll()
    }
    
    private func output() {
        if Double(Int(result)) - result == 0 {
            enter.text = String(Int(result))
        }
        else {
            enter.text = String(result)
        }
    }
    
    private func offAll() {
        isActPlus = false
        isActMinus = false
        isActMultiply = false
        isActDevide = false
    }
    
//    MARK: - GREAT IDEA !!!
    
//    func offAndOnSomething(what on: Bool) {
//
//    }
}
