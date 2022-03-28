//
//  OkCancelAlert.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 27.01.2022.
//

import UIKit
extension UIViewController {
    func  alertOkCancel(title: String, message: String?, copletionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert) //создаем алерт
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            copletionHandler()
        } //создали кнопку на алерт
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(ok) //добавили кнопку на алерт
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil) //показ алерта
    }
}
