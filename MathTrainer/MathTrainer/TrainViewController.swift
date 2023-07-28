//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Марина Журавлева on 12.07.2023.
//

import UIKit

final class TrainViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var secondButtonsCollection: [UIButton]!
    
    private func configureButtons() {
        // Add shadow
        secondButtonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 3
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
    }
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
}
