//
//  CalculatorController.swift
//  Calculator
//
//  Created by Сэнди Белка on 17.04.2021.
//

import UIKit

final public class CalculatorController {
    
    private let plus: UIButton
    private let minus: UIButton
    private let multiply: UIButton
    private let devide: UIButton
    private let enter: UILabel
    private let ac: UIButton
    
    private var result = 0.0
    private var firstEnter = 0.0
    private var secondEnter = 0.0
    
    private var negative = false
    private var isAct = false
    private var isActPlus = false
    private var isActMinus = false
    private var isActDevide = false
    private var isActMultiply = false
    private var isSecondEnter = false
    private var isItFraction = false
    
    init(plus: UIButton, minus: UIButton, multiply: UIButton, devide: UIButton, enter: UILabel, ac: UIButton) {
        self.plus = plus
        self.minus = minus
        self.multiply = multiply
        self.devide = devide
        self.enter = enter
        self.ac = ac
    }
    
    //MARK: - ac
    public func didSelectAC() {
        ac.setTitle("AC", for: .normal)
        enter.text = "0"
        result = 0.0
        negative = false
        isAct = false
        defaultSet()
        isSecondEnter = false
        isItFraction = false
        changeColorBack()
    }
    
    //MARK: - negative or positive
    public func didSelectPlusOrMinus() {
        negative = !negative
        guard let indexStart = enter.text?.startIndex else {return }
        if !isAct && negative && !(enter.text?.contains("-"))!{
            enter.text?.insert("-", at: indexStart)
            result = Double(enter.text!)!
        }
        else if ((enter.text?.firstIndex(of: "-")) != nil) && !isAct {
            enter.text?.remove(at: (enter.text?.firstIndex(of: "-"))!)
            result *= -1
        }
        else if isAct {
            changeColorBack()
            firstEnter = Double(enter.text!)!
            enter.text = "-0"
            isSecondEnter = true
            isAct = false
        }
    }
    
    //MARK: - Procent
    public func didSelectProcent() {
        result /= 100
        isAct = true
        output()
    }
    
    //MARK: - Multiply
    public func didSelectMultiply() {
        defaultSet()
        changeColorBack()
        changeColor(multiply)
        isAct = true
        isActMultiply = true
        isItFraction = false
    }
    
    //MARK: - Devide
    public func didSelectDevide() {
        defaultSet()
        changeColorBack()
        changeColor(devide)
        isAct = true
        isActDevide = true
        isItFraction = false
    }
    
    //MARK: - Plus
    public func didSelectPlus() {
        defaultSet()
        changeColorBack()
        changeColor(plus)
        isAct = true
        isActPlus = true
        isItFraction = false
    }
    
    //MARK: - Minus
    public func didSelectMinus() {
        defaultSet()
        changeColorBack()
        changeColor(minus)
        isAct = true
        isActMinus = true
        isItFraction = false
    }
    
    //MARK: - FractionalPart
    public func didSelectFractionalPart() {
        guard let text = enter.text else {return }
        if !isAct && !isItFraction && !((text.contains("."))) {
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
    
    //MARK: - Equally
    public func didSelectEqually() {
        isAct = true
        if isSecondEnter == true {
            secondEnter = result
            isSecondEnter = false
            getResult()
        }
    }

    //MARK: - get result
    private func getResult() {
        if isActPlus {
            result = firstEnter + secondEnter
        }
        else if isActMinus {
            result = firstEnter - secondEnter
        }
        else if isActMultiply {
            result = firstEnter * secondEnter
        }
        else if isActDevide {
            if secondEnter != 0.0 {
                result = firstEnter / secondEnter
            }
            else {
                enter.text = "Ошибка"
            }
        }
        if enter.text != "Ошибка" {
            output()
        }
        defaultSet()
    }
    
//    MARK: - function for default
    private func defaultSet() {
        
        isAct = false
        isActPlus = false
        isActMinus = false
        isActMultiply = false
        isActDevide = false
    }
    
    private func changeColorBack() {
        plus.backgroundColor = .orange
        plus.setTitleColor(.white, for: .normal)
        
        minus.backgroundColor = .orange
        minus.setTitleColor(.white, for: .normal)
        
        multiply.backgroundColor = .orange
        multiply.setTitleColor(.white, for: .normal)
        
        devide.backgroundColor = .orange
        devide.setTitleColor(.white, for: .normal)
    }
    
    private func changeColor(_ button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.orange, for: .normal)
    }
    
    //    MARK: - output
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
    
    //    MARK: - spaces
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
    
    //MARK: - write Number
    public func writeNumber(_ num: Int) {
        if enter.text?.count == 11 && !isAct {return }
        
        if isAct {
            changeColorBack()
            firstEnter = result
            enter.text = ""
            isSecondEnter = true
            isAct = false
        }
        
        guard var string = enter.text else {return }
        
        ac.setTitle("C", for: .normal)
        
        let numStr = String(num)
        
        if !isAct && enter.text != "0" && enter.text != "-0" {
            string += numStr
            string = removeSpaces(with: string)
            if !string.contains(".") {
                enter.text! = outputWithSpaces(with: string)
            }
            else {
                enter.text! += numStr
            }
        }
        else {
            if enter.text == "-0" && num != 0{
                enter.text = "-" + numStr
            }
            else if enter.text == "0" {
                enter.text = numStr
            }
            string = enter.text!
        }
        result = Double(string) ?? 0
    }
}
