//
//  RepsAndTimerView.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 19.01.2022.
//

import UIKit

class RepsAndTimerView: UIView {

    private let setsLabel: UILabel = {
       let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
     let numberOfSetLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label

    } ()
    
     let setsSlider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.minimumTrackTintColor = .specialGreen
        slider.maximumTrackTintColor = .specialLightBrown
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(setSlaiderChanged), for: .valueChanged)
        return slider
    } ()
    
    private let repeatOrTimerLabel = UILabel(text: "Choose repeat or timer")
   
    
    private let repsLabel: UILabel = {
        let label = UILabel()
         label.text = "Reps"
         label.font = .robotoMedium18()
         label.textColor = .specialGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    } ()
    
     let numberOfRepsLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
       slider.addTarget(self, action: #selector(repsSliderChanged), for: .valueChanged)
        return slider
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
         label.text = "Timer"
         label.font = .robotoMedium18()
         label.textColor = .specialGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
       
    } ()
    
     let numberOfTimerLabel: UILabel = {
        let label = UILabel()
         label.text = "0"
         label.font = .robotoMedium24()
         label.textColor = .specialGray
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    } ()
    
     let timerSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 600
        slider.maximumTrackTintColor = .specialLightBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(timerSliderChanged), for: .valueChanged)
        return slider
    } ()
    //MARK: - Создадим StackView:
    var setsStackView = UIStackView()
    var repsStackView = UIStackView()
    var timerStackView = UIStackView()

    
    
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
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetLabel], axis: .horizontal, spacing: 10)
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel], axis: .horizontal, spacing: 10)
        timerStackView = UIStackView(arrangedSubviews: [timerLabel, numberOfTimerLabel], axis: .horizontal, spacing: 10)
        //Добавил на вью
        addSubview(setsStackView)
        addSubview(setsSlider)
        addSubview(repeatOrTimerLabel)
        addSubview(repsStackView)
        addSubview(repsSlider)
        addSubview(timerStackView)
        addSubview(timerSlider)
    }
    //MARK: - Методы для Slaider(ов)
    @objc private func setSlaiderChanged() {
        numberOfSetLabel.text = "\(Int(setsSlider.value))" //записываем значение со слайдера в лайбел
    }
    @objc private func repsSliderChanged() {
        numberOfRepsLabel.text = "\(Int(repsSlider.value))" //записываем значение со слайдера в лайбел
      setNegative(label: timerLabel, numberLabel: numberOfTimerLabel, slider: timerSlider)//используем методы
        setActive(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
        
    }
    @objc private func timerSliderChanged() {
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(timerSlider.value))
        numberOfTimerLabel.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min") //через тернарный оператор условия. Если секунды не равны нулю тогда выполняется первое выражение, если равны то второе
        setNegative(label: repsLabel, numberLabel: numberOfRepsLabel, slider: repsSlider)
        setActive(label: timerLabel, numberLabel: numberOfTimerLabel, slider: timerSlider)
        
    }
    //MARK: - Методы представления для  reps or timer
    
    private func setActive(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 1
        numberLabel.alpha = 1
        slider.alpha = 1
    }
    private func setNegative(label: UILabel, numberLabel: UILabel, slider: UISlider) {
        label.alpha = 0.5
        numberLabel.alpha = 0.5
        numberLabel.text = "0" //изменяем значение текста numberLabel на 0, так как он не активен
        slider.alpha = 0.5
        slider.value = 0 //значение сладера тоже делаем ноль
    }
}
//MARK: - Расширение для класса, создание метода setConstrains()
extension RepsAndTimerView {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            setsSlider.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            repeatOrTimerLabel.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 15),
            repeatOrTimerLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: repeatOrTimerLabel.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
    }
}
