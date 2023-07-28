//
//  ViewController.swift
//  MathTrainer
//
//  Created by Марина Журавлева on 11.07.2023.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet var addScoreLabel: UILabel!
    @IBOutlet var subtractScoreLabel: UILabel!
    @IBOutlet var multiplyScoreLabel: UILabel!
    @IBOutlet var divideScoreLabel: UILabel!
    
    // MARK: - Properties
    var selectedType: MathTypes = .add
    
    private var addScore = 0 {
        didSet {
            addScoreLabel.text = "\(addScore)"
        }
    }
    
    private var subtractScore = 0 {
        didSet {
            subtractScoreLabel.text = "\(subtractScore)"
        }
    }
    
    private var multiplyScore = 0 {
        didSet {
            multiplyScoreLabel.text = "\(multiplyScore)"
        }
    }
    
    private var divideScore = 0 {
        didSet {
            divideScoreLabel.text = "\(divideScore)"
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtons()
        
        loadScores()
        
        updateScoreLabels()
        
        if let trainViewController = children.first as? TrainViewController {
            trainViewController.scoreUpdated = { [weak self] type, score in
                self?.updateScore(for: type, score: score)
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        if let trainViewController = unwindSegue.source as? TrainViewController {
                    switch trainViewController.type {
                    case .add:
                        addScore = trainViewController.currentScore
                    case .subtract:
                        subtractScore = trainViewController.currentScore
                    case .multiply:
                        multiplyScore = trainViewController.currentScore
                    case .divide:
                        divideScore = trainViewController.currentScore
                    }

            saveScores()
            updateScoreLabels()
        }
    }
    
    // MARK: - Score Management
       private func loadScores() {
           addScore = UserDefaults.standard.integer(forKey: "addScore")
           subtractScore = UserDefaults.standard.integer(forKey: "subtractScore")
           multiplyScore = UserDefaults.standard.integer(forKey: "multiplyScore")
           divideScore = UserDefaults.standard.integer(forKey: "divideScore")
       }
    
    private func updateScoreLabels() {
           addScoreLabel.text = "\(addScore)"
           subtractScoreLabel.text = "\(subtractScore)"
           multiplyScoreLabel.text = "\(multiplyScore)"
           divideScoreLabel.text = "\(divideScore)"
       }
    
    private func saveScores() {
        UserDefaults.standard.set(addScore, forKey: "addScore")
        UserDefaults.standard.set(subtractScore, forKey: "subtractScore")
        UserDefaults.standard.set(multiplyScore, forKey: "multiplyScore")
        UserDefaults.standard.set(divideScore, forKey: "divideScore")
        
        UserDefaults.standard.synchronize()
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
            
            viewController.scoreUpdated = { [weak self] type, score in
                self?.updateScore(for: type, score: score)
            }
        }
    }
        private func configureButtons() {
            // Add shadow
            buttonsCollection.forEach { button in
                button.layer.shadowColor = UIColor.darkGray.cgColor
                button.layer.shadowOffset = CGSize(width: 0, height: 2)
                button.layer.shadowOpacity = 0.4
                button.layer.shadowRadius = 3
            }
        }
        
        private func updateScore(for type: MathTypes, score: Int) {
            switch type {
            case .add:
                addScore = score
            case .subtract:
                subtractScore = score
            case .multiply:
                multiplyScore = score
            case .divide:
                divideScore = score
            }
        }
}
