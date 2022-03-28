//
//  SimpleAlert.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 23.01.2022.
//

import UIKit
extension UIViewController {
    func  alertOk(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert) //создаем алерт
        let ok = UIAlertAction(title: "OK", style: .default) //создали кнопку на алерт
        alertController.addAction(ok) //добавили кнопку на алерт
        present(alertController, animated: true, completion: nil) //показ алерта
    }
}
