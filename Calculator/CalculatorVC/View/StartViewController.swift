//
//  StartViewController.swift
//  Calculator
//
//  Created by Сэнди Белка on 06.11.2020.
//

import UIKit

final class StartViewController: UIViewController {

    @IBOutlet weak var enter: UILabel!
    @IBOutlet weak var ac: UIButton!
    @IBOutlet weak var devide: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var plusOrMinus: UIButton!
    @IBOutlet weak var procent: UIButton!
    @IBOutlet weak var equal: UIButton!
    @IBOutlet weak var dote: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!

    
    lazy private var controller = CalculatorController(plus: plus, minus: minus, multiply: multiply, devide: devide, enter: enter, ac: ac)

    
    override func viewDidLayoutSubviews() {
        makeButtonsRounded()
    }
    
    //MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        enter.text = "0"
    }
    
    
    @IBAction func didSelectAC(_ sender: UIButton) {
        controller.didSelectAC()
    }
    
    @IBAction func didSelectPlusOrMinus(_ sender: UIButton) {
        controller.didSelectPlusOrMinus()
    }
    
    @IBAction func didSelectProcent(_ sender: UIButton) {
        controller.didSelectProcent()
    }
    
    @IBAction func didSelectMultiply(_ sender: UIButton) {
        controller.didSelectMultiply()
    }

    @IBAction func didSelectDevide(_ sender: UIButton) {
        controller.didSelectDevide()
    }
    
    @IBAction func didSelectPlus(_ sender: UIButton) {
        controller.didSelectPlus()
    }
    
    @IBAction func didSelectMinus(_ sender: UIButton) {
        controller.didSelectMinus()
    }
    

    
    @IBAction func didSelectFractionalPart(_ sender: UIButton) {
        controller.didSelectFractionalPart()
    }
    
    @IBAction func didSelectEqually(_ sender: UIButton) {
        controller.didSelectEqually()
    }
    
    
    @IBAction func nine(_ sender: UIButton) {
        controller.writeNumber(9)
    }
    
    @IBAction func eight(_ sender: UIButton) {
        controller.writeNumber(8)
    }
    
    @IBAction func seven(_ sender: UIButton) {
        controller.writeNumber(7)
    }
    
    @IBAction func six(_ sender: UIButton) {
        controller.writeNumber(6)
    }
    
    @IBAction func five(_ sender: UIButton) {
        controller.writeNumber(5)
    }

    @IBAction func four(_ sender: UIButton) {
        controller.writeNumber(4)
    }
    
    @IBAction func three(_ sender: UIButton) {
        controller.writeNumber(3)
    }
    
    @IBAction func two(_ sender: UIButton) {
        controller.writeNumber(2)
    }
    
    @IBAction func one(_ sender: UIButton) {
        controller.writeNumber(1)
    }
    
    @IBAction func zero(_ sender: UIButton) {
        if enter.text != "0" {
            controller.writeNumber(0)
        }
    }
    
    //MARK: - corner radius
    private func makeButtonsRounded() {

        let cornerRadius1 = ac.frame.height * 0.5
        let cornerRadius2 = ac.frame.width * 0.5
        let cornerRadius = cornerRadius1 >= cornerRadius2 ? cornerRadius2 : cornerRadius1
        
        ac.layer.cornerRadius = cornerRadius
        devide.layer.cornerRadius = cornerRadius
        multiply.layer.cornerRadius = cornerRadius
        plus.layer.cornerRadius = cornerRadius
        minus.layer.cornerRadius = cornerRadius
        plusOrMinus.layer.cornerRadius = cornerRadius
        procent.layer.cornerRadius = cornerRadius
        equal.layer.cornerRadius = cornerRadius
        dote.layer.cornerRadius = cornerRadius
        one.layer.cornerRadius = cornerRadius
        two.layer.cornerRadius = cornerRadius
        three.layer.cornerRadius = cornerRadius
        four.layer.cornerRadius = cornerRadius
        five.layer.cornerRadius = cornerRadius
        six.layer.cornerRadius = cornerRadius
        seven.layer.cornerRadius = cornerRadius
        eight.layer.cornerRadius = cornerRadius
        nine.layer.cornerRadius = cornerRadius
        zero.layer.cornerRadius = zero.frame.height * 0.5
    }
}
