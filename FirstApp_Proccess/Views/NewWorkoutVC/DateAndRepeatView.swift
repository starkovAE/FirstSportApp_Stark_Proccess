//
//  DateAndRepeatView.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 19.01.2022.
//

import UIKit

class DateAndRepeatView: UIView {

    private let dateLabel: UILabel = {
      let label = UILabel()
        label.text = "Date"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   let datePicker: UIDatePicker = {
      let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date //настройка пикера на дату или время
        datePicker.tintColor = .specialGreen //цвет подцветки
        datePicker.translatesAutoresizingMaskIntoConstraints = false
       return  datePicker
    }()
    
    private let repeatLabel: UILabel = {
      let label = UILabel()
        label.text = "Repeat every 7 days"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let repeatSwitch: UISwitch = {
      let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true // свитч будет сразу активен
        repeatSwitch.onTintColor = .specialGreen //цвет активной части
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    } ()
    //MARK: - Создание stackView
    var dateStackView = UIStackView()
    var repeatStackView = UIStackView()
    
    
    
    //MARK: - Инициализаторы:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    //MARK: - Метод setupViews
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        //Настроил stackView
        dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker], axis: .horizontal, spacing: 10) //axis - ось, spacing - интервал
        repeatStackView = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch], axis: .horizontal, spacing: 10)
        //добавил stackView на view
        addSubview(dateStackView)
        addSubview(repeatStackView)
    }

}
//MARK: - Расширение для класса, создание метода setConstrains()
extension DateAndRepeatView {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
