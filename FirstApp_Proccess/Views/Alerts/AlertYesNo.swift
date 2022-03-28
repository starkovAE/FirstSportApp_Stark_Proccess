//
//  AlertYesNo.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 02.02.2022.
//
import UIKit
extension UIViewController {
    func  alertYesNo(title: String, message: String?, copletionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert) //создаем алерт
        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            copletionHandler()
        } //создали кнопку на алерт
        let no = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(yes) //добавили кнопку на алерт
        alertController.addAction(no)
        present(alertController, animated: true, completion: nil) //показ алерта
    }
}
