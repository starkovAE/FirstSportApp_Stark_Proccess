//
//  CalendarCollectionViewCell.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 16.01.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
   
    //MARK: - Создание label - dayOfWeeKLabel для ячейки
    private let dayOfWeeKLabel: UILabel =  {
        let label = UILabel()
//        label.text = "Mon"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center //выравнивание текста
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    //НОВОЕ
    func setLabelDayOfWeek(name: String = "Mon") {
        dayOfWeeKLabel.text = name 
    }
    //MARK: - Создание label - numberOfDay для ячейки
     let numberOfDayLabel: UILabel =  {
        let label = UILabel()
        label.text = "29"
        label.font = .robotoBold20()
        label.textColor = .white
        label.textAlignment = .center //выравнивание текста
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    //MARK: - isSelected - что происходит если ячейка выбрана
    override var isSelected: Bool { //Что происходит если ячейка нажата
        didSet {
            if self.isSelected { //если выбрана
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeeKLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else { //если нет
                backgroundColor = .specialGreen
                dayOfWeeKLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews() //вызвали метод
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //переводится: инициализатор не был реализован
    }
    //MARK: - Метод setupViews()
        private func setupViews() {
            
           addSubview(dayOfWeeKLabel) //добавили их на вьюху
            addSubview(numberOfDayLabel)
        }
    //MARK: - cellConfigure() !!!! Посмотреть про него
    //Данный метод конфигурирует ячейку
    func cellConfigure(weekArray: [[String]], indexPath: IndexPath) { //мы в него передаем двумернй массив и индекс
        numberOfDayLabel.text = weekArray[1][indexPath.item] // в соответсвии с индексом ячейки берется индекс из массива
        dayOfWeeKLabel.text = weekArray[0][indexPath.item]
    }
    //MARK: - setConstaints()
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            dayOfWeeKLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeeKLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            numberOfDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
    }
}
