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
    
   // MARK: - Properties
    var selectedType: MathTypes = .add
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
    }
    
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }

    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 3
        }
    }
}

