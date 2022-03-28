//
//  DetailsView.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 23.01.2022.
//

import UIKit
protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
    func editingTapped()
}
class DetailsView: UIView {
     let exerciseLabel: UILabel = {
       let label = UILabel()
        label.text = "Biceps"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center //выравнивание по центру
        label.adjustsFontSizeToFitWidth = true //уменьшение шрифта от ширины
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
    private let setsLabel: UILabel = {
       let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
   let setsNumberLabel: UILabel = {
       let label = UILabel()
        label.text = "1/4"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
    private let repsLabel: UILabel = {
       let label = UILabel()
        label.text = "Reps"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
     let repsNumberLabel: UILabel = {
       let label = UILabel()
        label.text = "20"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
    private let editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pencil")?.withRenderingMode(.alwaysOriginal), for: .normal) //добавляем Image из Assets
        button.setTitle("Editing", for: .normal) //добавляем заголовок, стиль нормал
        button.titleLabel?.font = .robotoBold16() //добавляем шрифт к нашему заголовку
        button.tintColor = .specialLightBrown // подцвечивать цветом наш текст и Image
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        return button
    } ()
    @objc private func editingButtonTapped() {
        print("tap editing button")
        
        cellNextDelegate?.editingTapped()
    }
    
    private let nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("NEXT SET", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .specialGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextSetTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    @objc private func nextSetTapped() {
        print("tap next set")
        cellNextDelegate?.nextSetTapped()
    }
    
    private let straightView1: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    private let straightView2: UIView = {
        let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
//MARK: - Инициализируем StackView
    var setsStackView = UIStackView()
    var repsStackView = UIStackView()
    //MARK: - Создаем слабую ссылку weak
    weak var cellNextDelegate: NextSetProtocol?
    
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
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, setsNumberLabel], axis: .horizontal, spacing: 10)
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsNumberLabel], axis: .horizontal, spacing: 10)
      
        addSubview(exerciseLabel)
        addSubview(setsStackView)
        addSubview(straightView1)
        addSubview(repsStackView)
        addSubview(straightView2)
        addSubview(editingButton)
        addSubview(nextSetButton)
    }

}
//MARK: - Расширение для класса, создание метода setConstrains()
extension DetailsView {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            exerciseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            exerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: exerciseLabel.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            setsStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        NSLayoutConstraint.activate([
            straightView1.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 2),
            straightView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            straightView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            straightView1.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: straightView1.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            repsStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
         straightView2.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 2),
         straightView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         straightView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
         straightView2.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: straightView2.bottomAnchor, constant: 10),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 20),
            editingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 10),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextSetButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

