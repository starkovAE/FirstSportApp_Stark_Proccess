//
//  UIView + Extensions.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.01.2022.
//

import UIKit
 //Расширение для добавлении тени к view
extension UIView {
    func addShadowOnView(){
        layer.shadowColor  = UIColor.gray.cgColor
        layer.masksToBounds = false //маска до предела фолс
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0) //размеры
        layer.shadowOpacity = 0.7// непрозрачность
        layer.shadowRadius = 1.0 // радиус
    }
}
