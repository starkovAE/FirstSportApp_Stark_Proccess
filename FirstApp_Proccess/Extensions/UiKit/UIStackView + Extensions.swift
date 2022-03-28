//
//  UIStackView + Extensions.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.01.2022.
//

import UIKit
//  расширение разметка для для стак вьев
extension UIStackView {
    convenience init (arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis //ось
        self.spacing = spacing //интервал между вьюхами
        self.translatesAutoresizingMaskIntoConstraints = false // ТАМИК
    }
}
