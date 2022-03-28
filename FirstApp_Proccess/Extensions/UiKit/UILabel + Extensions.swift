//
//  UILabel + Extensions.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 18.01.2022.
//

import UIKit
extension UILabel {
   convenience init(text: String = "") { // convenience  init - обозначает вспомогательный инициализатор
       self.init()
       self.text = text
       self.font = .robotoMedium14()
       self.textColor = .specialLightBrown
       self.translatesAutoresizingMaskIntoConstraints = false
   }
}
