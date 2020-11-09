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
    @IBOutlet weak var devideOut: UIButton!
    @IBOutlet weak var multiplyOut: UIButton!
    @IBOutlet weak var minusOut: UIButton!
    @IBOutlet weak var plusOut: UIButton!
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
        defaultSet()
        isSecondEnter = false
        isItFraction = false
        changeColorBack()
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
        defaultSet()
        changeColorBack()
        changeColor(multiplyOut)
        isAct = true
        isActMultiply = true
        isItFraction = false
    }

    @IBAction func devide(_ sender: UIButton) {
        defaultSet()
        changeColorBack()
        changeColor(devideOut)
        isAct = true
        isActDevide = true
        isItFraction = false
    }
    
    @IBAction func plus(_ sender: UIButton) {
        defaultSet()
        changeColorBack()
        changeColor(plusOut)
        isAct = true
        isActPlus = true
        isItFraction = false
    }
    
    @IBAction func minus(_ sender: UIButton) {
        defaultSet()
        changeColorBack()
        changeColor(minusOut)
        isAct = true
        isActMinus = true
        isItFraction = false
    }
    

    
    @IBAction func fractionalPart(_ sender: UIButton) {
        
        guard let _ = enter.text else {return }
        if !isAct && !isItFraction && !((enter.text?.contains("."))!) {
            isItFraction = true
            enter.text! += "."
        }
        else if isAct {
            changeColorBack()
            firstEnter = result
            isItFraction = true
            enter.text = "0."
            isSecondEnter = true
            isAct = false
        }
        
    }
    
    @IBAction func equally(_ sender: UIButton) {
        isAct = true
        if isSecondEnter == true {
            if let second = enter.text {
                if let secondDouble = Double(second) {
                    isSecondEnter = false
                    getResult(second: secondDouble)
                }
            }
        }
    }
    
    private func writeNumber(_ num: Int) {
        if enter.text?.count == 9 && !isAct {return }
        
        if isAct == true {
            changeColorBack()
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
    
    private func getResult(second num: Double) {
        
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
        defaultSet()
    }
    
    private func output() {
        
        if Double(Int(result)) - result == 0 {
            let intResultStr = String(Int(result))
            if intResultStr.count > 9 {
                if let lastNum = intResultStr.last {
                    enter.text = String(intResultStr.prefix(8)) + ".." + String(lastNum)
                }
            }
            else {
                enter.text = intResultStr
            }
        }
        else {
            let doubleRsultStr = String(result)
            if doubleRsultStr.count > 10 {
                if let lastNum = doubleRsultStr.last {
                    enter.text = String(doubleRsultStr.prefix(9)) + ".." + String(lastNum)
                }
            }
            else {
                enter.text = doubleRsultStr
            }
        }
    }
    
    private func changeColor(_ button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.orange, for: .normal)
    }
    
    private func changeColorBack() {
        plusOut.backgroundColor = .orange
        plusOut.setTitleColor(.white, for: .normal)
        
        minusOut.backgroundColor = .orange
        minusOut.setTitleColor(.white, for: .normal)
        
        multiplyOut.backgroundColor = .orange
        multiplyOut.setTitleColor(.white, for: .normal)
        
        devideOut.backgroundColor = .orange
        devideOut.setTitleColor(.white, for: .normal)
    }
    
    private func defaultSet() {
        isActPlus = false
        isActMinus = false
        isActMultiply = false
        isActDevide = false
    }
    
//    MARK: - GREAT IDEA !!!
    
//    func offAndOnSomething(what on: Bool) {
//
//    }
    
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
}
