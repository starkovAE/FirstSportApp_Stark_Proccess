//
//  StatisticTableViewCell.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 31.01.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {
    

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     private let workoutNameLabel: UILabel = {
        let label = UILabel()
         label.textColor = .specialBlack
         label.font = .robotoMedium22()
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     private let beforeRepsLabel: UILabel = {
        let label = UILabel()
         label.text = "Before: 18"
         label.textColor = .specialTabBar
         label.font = .robotoMedium14()
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     private let nowRepsLabel: UILabel = {
        let label = UILabel()
         label.text = "Now: 20"
         label.textColor = .specialTabBar
         label.font = .robotoMedium14()
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     private let statisticRepsLabel: UILabel = {
        let label = UILabel()
         label.text = "+2"
         label.textColor = .specialGreen
         label.font = .robotoMedium24()
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
   var labelsStackView = UIStackView()
    
    // MARK: - Инициализаторы
         override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)

                setupViews()
                setConstrains()
            }

            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
  
     //MARK: - setupViews()
     private func setupViews() {
         backgroundColor = .clear
         selectionStyle = .none
         

         addSubview(workoutNameLabel)
         addSubview(statisticRepsLabel)
          
         labelsStackView = UIStackView(arrangedSubviews: [beforeRepsLabel, nowRepsLabel],
                                       axis: .horizontal,
                                       spacing: 10)
         addSubview(labelsStackView)
         addSubview(separatorView)
         
     }
     func cellConfigure(differenceWorkout: DifferenceWorkout) {
        workoutNameLabel.text = differenceWorkout.name
        beforeRepsLabel.text = "Before: \(differenceWorkout.firstReps)"
        nowRepsLabel.text = "Now: \(differenceWorkout.lastReps)"
        let difference = differenceWorkout.lastReps - differenceWorkout.firstReps
        statisticRepsLabel.text = "\(difference)"
        switch difference {
        case ..<0 :
            statisticRepsLabel.textColor = .specialDarkYellow
        case 1...:
            statisticRepsLabel.textColor = .specialGreen 
        default:
            statisticRepsLabel.textColor = .specialGray
        }
    
    }
 } //закрывает класс

    
extension StatisticTableViewCell {
    private func setConstrains() { //метод для констреинтов
      
        NSLayoutConstraint.activate([
            workoutNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: statisticRepsLabel.leadingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        ])
        NSLayoutConstraint.activate([
            statisticRepsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            statisticRepsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            statisticRepsLabel.widthAnchor.constraint(equalToConstant: 50)
          
        ])
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
          
        ])

  }
}
   
    

   

