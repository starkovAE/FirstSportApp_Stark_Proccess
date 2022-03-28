//
//  GalaryOrPhotoAlert.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 05.02.2022.
//

import UIKit
extension UIViewController {
    func alertPhotoOrCamera(completionHandler: @escaping (UIImagePickerController.SourceType) -> Void) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet) //сам алерт (где будем выбирать камера или галерея
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in //это камера
            let camera = UIImagePickerController.SourceType.camera
            completionHandler(camera) //добавляем в замыкание
        }
        
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in //это галерея
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            completionHandler(photoLibrary) //добавляем в замыкание
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(camera) //добавили действие на алерт
        alertController.addAction(photoLibrary)
        alertController.addAction(cancel)
        
        present(alertController, animated: true) // показваем
    }
}
