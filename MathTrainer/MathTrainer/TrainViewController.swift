//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Марина Журавлева on 12.07.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    private var isAnsweredCorrectly = false
    
    var currentScore: Int = 0
    
    var scoreUpdated: ((MathTypes, Int) -> Void)?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configureButtons()
        updateScoreLabel()
    }
    
    // MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    // MARK: - Methods
    private func configureButtons() {
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        // Add shadow
        [leftButton, rightButton].forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 2)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 1)...(answer + 1))
        } while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) :
                                String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) :
                                String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 2...99)
        
        switch type {
        case .add, .subtract, .multiply:
            break
        case .divide:
            var validDivisors: [Int] = []
            for divisor in 2...secondNumber {
                if firstNumber % divisor == 0 {
                    validDivisors.append(divisor)
                }
            }
            if let randomDivisor = validDivisors.randomElement() {
                secondNumber = randomDivisor
            } else {
                repeat {
                    secondNumber = Int.random(in: 2...99)
                } while firstNumber % secondNumber != 0
            }
        }
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        guard let userAnswer = Int(answer) else {
            return
        }
        
        let isRightAnswer = userAnswer == self.answer
        
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        
        if isRightAnswer && !isAnsweredCorrectly {
            currentScore += 1
            scoreUpdated?(type, currentScore)
            updateScoreLabel()
            isAnsweredCorrectly = true
            
            switch type {
            case .add:
                UserDefaults.standard.set(currentScore, forKey: "addScore")
            case .subtract:
                UserDefaults.standard.set(currentScore, forKey: "subtractScore")
            case .multiply:
                UserDefaults.standard.set(currentScore, forKey: "multiplyScore")
            case .divide:
                UserDefaults.standard.set(currentScore, forKey: "divideScore")
            }
            UserDefaults.standard.synchronize()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.configureQuestion()
            self?.configureButtons()
            self?.isAnsweredCorrectly = false
        }
    }
    private func updateScoreLabel() {
        scoreLabel.text = "Score: \(currentScore)"
    }
}
