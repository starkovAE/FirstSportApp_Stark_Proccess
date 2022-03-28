//
//  StartWorkoutViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 23.01.2022.
//

import UIKit

class StartWorkoutViewController: UIViewController {

    private let startWorkoutLabel: UILabel = {
       let label = UILabel()
        label.text = "START WORKOUT"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()
    
    private let clouseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "CloseButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clouseButtonTapped), for: .touchUpInside)
        return button
    } ()
    @objc private func clouseButtonTapped() {
        dismiss(animated: true, completion: nil) //закрывает и выгружает из памяти view
        print("View закртыта и выгружена из памяти")
    }
    
    private let sportsManImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "sportsman") //добавил картинку
        imageView.contentMode = .scaleAspectFit //Возможность масштабировать содержимое в соответствии с размером представления, сохраняя соотношение сторон.
        imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    } ()
    

    private let detailsLabel = UILabel(text: "Details")
    

    private let detailsView = DetailsView()
    
    
    private let finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    } ()
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true) //происходит выгрузка экрана из памяти  и он прячется
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        } else { //если например 2/3 и мы нажмем finish, то откроется алерт и выгрузится этот VC
            alertOkCancel(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true) //тут мы тоже закрываем этот ViewController
            }
        }
    }
    
    var workoutModel = WorkoutModel() //создали экземпляр модели
    let customAlert = CustomAlert() //создали экземпляр Алерта
    private var numberOfSet = 1 //счетчик сетов
 
    //MARK: - Метод viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        clouseButton.layer.cornerRadius = clouseButton.frame.height / 2 //перерисовываем и скругляем нашу кнопку в зависимости от ее высоты
        
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setWorkoutParametrs()
        print(workoutModel)
        setDelegetes()
       
    }
    //MARK: - setDelegates()
    private func setDelegetes() {
        detailsView.cellNextDelegate = self
    }
    
   //MARK: - setupViews()
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(clouseButton)
        view.addSubview(sportsManImageView)
        view.addSubview(detailsLabel)
        view.addSubview(detailsView)
        view.addSubview(finishButton)
    
    }
    private func setWorkoutParametrs() {
        detailsView.exerciseLabel.text = workoutModel.workoutName
        detailsView.setsNumberLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        detailsView.repsNumberLabel.text = "\(workoutModel.workoutReps)"
    }
}
//MARK: - extension NextSetProtocol
extension StartWorkoutViewController: NextSetProtocol {
    
    func editingTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Reps") { [self] sets, reps in
            if sets != "" && reps != "" { //если мы ничего не ввели 
            detailsView.setsNumberLabel.text = "\(numberOfSet)/\(sets)"
            detailsView.repsNumberLabel.text = reps
            guard let numberOfSets = Int(sets) else { return } 
            guard let numberOfReps = Int(reps) else { return }
            RealmManager.shared.updateSetsRepsWorkoutModel(model: workoutModel, sets: numberOfSets, reps: numberOfReps) //обновляем модель
        }
    }
 }
    
    func nextSetTapped() { //при нажатии на кнопку nexSet
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1 //происходит увеличение счетчика
            detailsView.setsNumberLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Compele", message: "We finish your workout")
        }
    }
    
    
}



//MARK: - extension setConstrains

extension StartWorkoutViewController {
        private func setConstrains() { //метод для констреинтов
            NSLayoutConstraint.activate([
                startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
            NSLayoutConstraint.activate([
                clouseButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
                clouseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                clouseButton.heightAnchor.constraint(equalToConstant: 30),
                clouseButton.widthAnchor.constraint(equalToConstant: 30)
            
            ])
            NSLayoutConstraint.activate([
               
                sportsManImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
                sportsManImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                sportsManImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                sportsManImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
            ])
            NSLayoutConstraint.activate([
                detailsLabel.topAnchor.constraint(equalTo: sportsManImageView.bottomAnchor, constant: 30),
                detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            ])
            NSLayoutConstraint.activate([
                detailsView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
                detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                detailsView.heightAnchor.constraint(equalToConstant: 230)
            
            ])
            NSLayoutConstraint.activate([
                finishButton.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 20),
                finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                finishButton.heightAnchor.constraint(equalToConstant: 55)
            
            ])

}
}
