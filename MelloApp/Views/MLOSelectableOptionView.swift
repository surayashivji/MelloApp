//
//  MLOSelectableOptionView.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 2/24/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

enum MLOSelectableOptionType {
    case timeOfDay, goal, mindfulness
    
    var options: [MLOSelectableListOption] {
        switch self {
        case .timeOfDay:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        case .goal:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        case .mindfulness:
            return [MLOSelectableListOption(title: "When I wake up",
                                            defaultColor: .purple,
                                            selectionColor: .white)]
        }
    }
}

struct MLOSelectableListOption {
    var title: String
    var defaultColor: UIColor
    var selectionColor: UIColor
}

class MLOSelectableOptionViewController: UIViewController {
    private var options: [MLOSelectableListOption] = []
    
    var selectedOptions: [MLOSelectableListOption] = []
    
//    init(_ type: MLOSelectableOptionType) {
//        options = type.options
//    }

}

protocol MLOSelectableOptionViewDelegate {
    func didSelect(option: MLOSelectableListOption)
}
