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
        guard let indexStart = enter.text?.startIndex else {return }
        if negative {
            enter.text?.insert("-", at: indexStart)
        }
        else {
            enter.text?.remove(at: (enter.text?.firstIndex(of: "-"))!)
        }
    }
    
    @IBAction func procent(_ sender: UIButton) {
        result /= 100
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
            if var second = enter.text {
                second = removeSpaces(with: second)
                if let secondDouble = Double(second) {
                    isSecondEnter = false
                    getResult()
                }
            }
        }
    }
    
    private func writeNumber(_ num: Int) {
        if enter.text?.count == 11 && !isAct {return }
        
        if isAct {
            changeColorBack()
            firstEnter = result
            enter.text = ""
            isSecondEnter = true
            isAct = false
        }
        
        guard var string = enter.text else {return }
        
        acOUt.setTitle("C", for: .normal)
        
        let numStr = String(num)
        
        if !isAct && enter.text != "0" {
            string += numStr
            string = removeSpaces(with: string)
            enter.text! = outputWithSpaces(with: string)
        }
        else {
            string = String(num)
            enter.text = numStr
        }
        

        instance += numStr
        string = removeSpaces(with: string)
        result = Double(string) ?? 0
    }
    
    private func getResult() {

        if isActPlus {
            result += firstEnter
        }
        else if isActMinus {
            result = firstEnter - result
        }
        else if isActMultiply {
            result *= firstEnter
        }
        else if isActDevide {
            if result != 0 {
                result = firstEnter / result
            }
        }
        
        if result != 0 {
            output()
        }
        else {
            enter.text = "Ошибка"
        }
        defaultSet()
    }
    
    private func output() {
        
        if Double(Int(result)) - result == 0 {
            var intResultStr = String(Int(result))
            if intResultStr.count > 9 {
                if let lastNum = intResultStr.last {
                    var resultStrPrefix = String(intResultStr.prefix(8))
                    resultStrPrefix = addSpaces(with: resultStrPrefix, to: 2)
                    enter.text = resultStrPrefix + ".." + String(lastNum)
                }
            }
            else {
                intResultStr = outputWithSpaces(with: intResultStr)
                enter.text = intResultStr
            }
        }
        else {
            let doubleResultString = String(result)
            guard let indexDote = doubleResultString.firstIndex(of: ".") else {return }
            let rangeInt = doubleResultString.startIndex ... indexDote
            var stringBeforeDote = String(doubleResultString[rangeInt])
            stringBeforeDote.removeLast()
            let rangeDouble = indexDote ..< doubleResultString.endIndex
            let stringAfterDote = String(doubleResultString[rangeDouble])
            stringBeforeDote = outputWithSpaces(with: stringBeforeDote)
            let stringCommon = stringBeforeDote + stringAfterDote
            enter.text = stringCommon
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
    
    private func outputWithSpaces(with string: String) -> String {
        
        var string = string
        if string.count > 6 {
            string = addSpaces(with: string, to: string.count - 6)
            string = addSpaces(with: string, to: string.count - 3)
        }
        else if string.count <= 6 && string.count >= 4 {
            string = addSpaces(with: string, to: string.count - 3)
        }
        return string
    }
    
    private func addSpaces(with string: String, to index: Int) -> String {
        
        var str = string
        let indexForSpace = str.index(str.startIndex, offsetBy: index)
        str.insert(" ", at: indexForSpace)
        return str
    }
    
    private func removeSpaces(with string: String) -> String {
        

        var string = string
        if let indexFirstSpace = string.firstIndex(of: " ") {
            string.remove(at: indexFirstSpace)
        }
        if let indexSecondSpace = string.lastIndex(of: " ") {
            string.remove(at: indexSecondSpace)
        }
        return string
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
}
