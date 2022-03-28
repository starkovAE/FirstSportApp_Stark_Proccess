//
//  CustomAlert.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 30.01.2022.
//

import Foundation
import UIKit

class CustomAlert {
   //ДЕЛАЕМ ВСЕ ФРЕИМАМИ ПОЭТОМУ ТАМИКИ НЕ СТАВИМ!
    private let backgroundView: UIView = { //создаем задний черный фон
     let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
      return view
    }()
    
    private let alertView: UIView = { //создаем алерт
     let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
    return view
    }()
    
    private let scrollView = UIScrollView()
    
    private var mainView: UIView?
    private let setsTextField = UITextField()
    private let repsTextField = UITextField()
    var buttonAction: ((String, String) -> Void)?
    
    var repsORTimer = "" //Будет принимать значение из инициализатора метода repsORTimer
    
    func alertCustom(viewController: UIViewController,repsOrTimer: String, completion: @escaping (String, String) -> Void) { // @escaping - сбегающее замыкание  - отрабатывает уже после вызова
        registerForKeyboardNotificaation() //регистрируем абсрерверы
        repsORTimer = repsOrTimer
        guard let parentView = viewController.view else { return } //у нас будет вьюха по размерам такая же как у VC
        mainView = parentView
        scrollView.frame = parentView.frame
        parentView.addSubview(scrollView)
        
        backgroundView.frame = parentView.frame //установим значение фрэйма как у parentView т.е. на весь экран
        scrollView.addSubview(backgroundView) //добавляем на parentView  темный экран
        
        alertView.frame = CGRect(x: 40,
                                 y: -420, //чтобы на начало анимации наша вьюха была выше черного экрана
                                 width: parentView.frame.width - 80, //берем всю ширину нашего экрана и вычитаем 80 (с двух сторон по 40)
                                 height: 420)
        scrollView.addSubview(alertView)
             setupCustomView()
             buttonAction = completion
             animate() //вызвали метод
    
            
    }
    
    private func setupCustomView() {
        //imageView
        let sportsmenImageView = UIImageView(frame: CGRect(x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
                                                           y: 30,
                                                           width: alertView.frame.height * 0.4,
                                                           height: alertView.frame.height * 0.4))
        sportsmenImageView.image = UIImage(named: "sportsGirl")
        sportsmenImageView.contentMode = .scaleAspectFit //чтобы картинка не растягивалась
        alertView.addSubview(sportsmenImageView) //добавили на алерт
        //editingLabel
        let editingLabel = UILabel(frame: CGRect(x: 10,
                                                 y: alertView.frame.height * 0.4 + 50,
                                                 width: alertView.frame.width - 20,
                                                 height: 25))
        editingLabel.text = "Editing"
        editingLabel.textAlignment = .center
        editingLabel.font = .robotoMedium22()
        alertView.addSubview(editingLabel) //добавили на алерт
        //setsLabel
        let setsLabel = UILabel(text: "Sets")
        setsLabel.translatesAutoresizingMaskIntoConstraints = true
        setsLabel.frame = CGRect(x: 30,
                                 y: editingLabel.frame.maxY + 10,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(setsLabel)
        //setsTextField
         setsTextField.frame = CGRect(x: 20,
                                                      y: setsLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30)
        setsTextField.backgroundColor = .specialBrown
        setsTextField.borderStyle = .none // свойство - стиль границы
        setsTextField.layer.cornerRadius = 10
        setsTextField.textColor = .specialGray
        setsTextField.font = .robotoBold20()
        setsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: setsTextField.frame.height)) //  - добавляется маленькая (шириной 15 поинтов) прозрачная вью для того чтобы текст вводился не по самой левой границе
        setsTextField.leftViewMode = .always // это свойство leftViewMode устновленное в always - говорит нам о том что мы это вьюху показываем всегда (always - всегда)
        setsTextField.clearButtonMode = .always // это свойство clearButtonMode установленное в always - это свойство  при вводе текста появляется кнопочка, при помощи которой можно очистить textFild
        setsTextField.returnKeyType = .done //это свойство  returnKeyTypе (для клавиатуры) - установили ее в done - сдесь можно делать доп настройки у клавиатуры
        setsTextField.keyboardType = .numberPad //будет выезжать клавиатура только с числами
        alertView.addSubview(setsTextField)
        //repsLabel
        let repsLabel = UILabel(text: "\(repsORTimer)")
        repsLabel.translatesAutoresizingMaskIntoConstraints = true
        repsLabel.frame = CGRect(x: 30,
                                 y: setsTextField.frame.maxY + 3,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(repsLabel)
        //repsTextField
        repsTextField.frame = CGRect(x: 20, y: repsLabel.frame.maxY,
                                                                     width: alertView.frame.width - 40,
                                                                                                        height: 30)
        repsTextField.backgroundColor = .specialBrown
        repsTextField.borderStyle = .none // свойство - стиль границы
        repsTextField.layer.cornerRadius = 10
        repsTextField.textColor = .specialGray
        repsTextField.font = .robotoBold20()
        repsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: repsTextField.frame.height)) //  - добавляется маленькая (шириной 15 поинтов) прозрачная вью для того чтобы текст вводился не по самой левой границе
        repsTextField.leftViewMode = .always // это свойство leftViewMode устновленное в always - говорит нам о том что мы это вьюху показываем всегда (always - всегда)
        repsTextField.clearButtonMode = .always // это свойство clearButtonMode установленное в always - это свойство  при вводе текста появляется кнопочка, при помощи которой можно очистить textFild
        repsTextField.returnKeyType = .done //это свойство  returnKeyTypе (для клавиатуры) - установили ее в done - сдесь можно делать доп настройки у клавиатуры
        repsTextField.keyboardType = .numberPad //будет выезжать клавиатура только с числами
        alertView.addSubview(repsTextField)
        //okButton
        let okButton = UIButton(frame: CGRect(x: 50,
                                              y: repsTextField.frame.maxY + 15,
                                              width: alertView.frame.width - 100,
                                              height: 35))
        okButton.backgroundColor = .specialGreen
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font  = .robotoMedium18()
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        alertView.addSubview(okButton)
       
    }
    private func animate() {
        guard let targetView = mainView else { return }
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.8 //делаем у нашу черной вьюху более прозрачной
        } completion: { done in //когда анимация закончилась
            if done { //если закончилась анимация, мы будем показывать наш алерт
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = targetView.center //parentView.center
                }
            }
        }

        
    }
    @objc private func okButtonTapped() { //у сергея - этот метод называется dismissAlert
        guard let setsNumber = setsTextField.text else { return }
        guard let repsNumber = repsTextField.text else { return }
        buttonAction?(setsNumber, repsNumber)
        
        guard let targetView = mainView else { return }
        UIView.animate(withDuration: 0.3) {
            self.alertView.frame = CGRect(x: 40,
                                          y: -420,
                                          width: targetView.frame.width - 80,
                                          height: 420)
        } completion: { done in //когда анимация закончилась
            if done { //если закончилась анимация, мы будем показывать наш алерт
                UIView.animate(withDuration: 0.3) {
                    self.backgroundView.alpha = 0 //parentView.center
                } completion: { done in
                    if done {
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        self.scrollView.removeFromSuperview()
                        self.removeForKeyboardNotificaation() //когда алерт будет пропадать, абесервер будет удаляться
                        self.setsTextField.text = ""
                        self.repsTextField.text = ""
                    }
                }
            }
        }
    }
  
    private func registerForKeyboardNotificaation()  { //метод создания работы с клавой (для показывания и скрытия клавиатуры)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeForKeyboardNotificaation() { //метод удаления работы с клавой (чтобы не захломлять память абсервирами)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func kbWillShow() {
        scrollView.contentOffset = CGPoint(x: 0, y: 100) //поднятие клавы
    }
    @objc private func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}
