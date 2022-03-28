//
//  WeatherView.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 17.01.2022.
//

import UIKit

class WeatherView: UIView {
   // MARK: - weatherStatusLabel
     let weatherStatusLabel : UILabel =  {
       let label = UILabel()
        label.text = "Солнечно"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.adjustsFontSizeToFitWidth = true // свойство - которое, уменьшает шрифт в зависимости от ширины label
        //свойство - которое уменьшает шрифт (шрифт на 30 % , на 50%)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    // MARK: - actionWeatherLabel
      let actionWeatherLabel : UILabel =  {
        let label = UILabel()
         label.text = "Хорошая погода, чтобы позаниматься на улице"
         label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
         label.font = .robotoMedium12()
         label.adjustsFontSizeToFitWidth = true // свойство - которое, уменьшает шрифт в зависимости от ширины 5
         label.numberOfLines = 2 //свойство - которое уменьшает шрифт (шрифт на 30 % , на 50%)
         label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
     } ()
  
    // MARK: - sunImageView
    
     let sunImageView: UIImageView = {
      let sunView = UIImageView()
        sunView.image = UIImage(named: "solar") //добавил картинку солнышка
        sunView.translatesAutoresizingMaskIntoConstraints = false
      return sunView
    } ()

    
    
    
    // MARK: - Инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
      setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Метод setupViews()
        private func setupViews() {
            backgroundColor = .white
            layer.cornerRadius = 10
            translatesAutoresizingMaskIntoConstraints = false
             addShadowOnView() //добавляет тень на вью
            
            addSubview(weatherStatusLabel)
            addSubview(actionWeatherLabel)
            addSubview(sunImageView)

            
        }

      
    }
//MARK: - setConstrains()
extension WeatherView {
    
        private func setConstrains() {
            
            NSLayoutConstraint.activate([
                sunImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                sunImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                sunImageView.heightAnchor.constraint(equalToConstant: 60),
                sunImageView.widthAnchor.constraint(equalToConstant: 60)
            ])
            NSLayoutConstraint.activate([
                weatherStatusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                weatherStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                weatherStatusLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: 10),
                weatherStatusLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
            NSLayoutConstraint.activate([
            actionWeatherLabel.topAnchor.constraint(equalTo: weatherStatusLabel.bottomAnchor, constant: 0),
            actionWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            actionWeatherLabel.trailingAnchor.constraint(equalTo: sunImageView.leadingAnchor, constant: -10),
            actionWeatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
           
          
        ])
    
       
            
        }
    
}

