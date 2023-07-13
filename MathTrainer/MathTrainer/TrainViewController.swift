//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Марина Журавлева on 12.07.2023.
//

import UIKit

final class TrainViewController: UIViewController  {
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
}
