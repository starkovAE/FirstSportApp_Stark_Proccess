//
//  TaimerWorkoutViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 26.01.2022.
//

import UIKit

class TaimerWorkoutViewController: UIViewController {
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
        timer.invalidate()
    }
    
   
    private let taimerImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "TaimerEllips") //добавил картинку
        imageView.contentMode = .scaleAspectFit //Возможность масштабировать содержимое в соответствии с размером представления, сохраняя соотношение сторон.
        imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    } ()
    
    private let taimerTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "01:30"
        label.font = .robotoBold40()
        label.textColor = .specialGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    } ()

    private let detailsLabel = UILabel(text: "Details")
    
    private let detailsTaimerView = DetailsTaimerWorkoutView()

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
     print("Finish button touch")
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finished your workout") {
                self.dismiss(animated: true) //тут мы тоже закрываем этот ViewController
            }
        }
        timer.invalidate() //останавливаем и обнуляем таймер
    }
    var workoutModel = WorkoutModel()
 
    
    let customAlert = CustomAlert()
    
    private var numberOfSet = 0
    
    //Для работы с анимацией:
    let shapeLayer = CAShapeLayer() //CoreAnimation
    
    //MARK: - Работа с Timer
    var timer = Timer()
    var durationTimer = 10 //свойство, которое показывает сколько будет работать наш таймер
    //MARK: - Метод viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        clouseButton.layer.cornerRadius = clouseButton.frame.height / 2 //перерисовываем и скругляем нашу кнопку в зависимости от ее высоты
        animationCircular() //вызываем этот метод сдесь, чтобы кружок появился, а потом наш бегунок. Если вызвать в во вьюДидиЛОад будет криво!
        
    }
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setWorkoutParameter()
        setDelegates()
        addTaps()
    }
    //MARK: - setDelegates()
    private func setDelegates() {
        detailsTaimerView.cellNextDelegates = self
    }
   //MARK: - setupViews()
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(clouseButton)
        view.addSubview(taimerTimeLabel)
        view.addSubview(taimerImageView)
        view.addSubview(detailsLabel)
        view.addSubview(detailsTaimerView)
        view.addSubview(finishButton)
      
    }
    private func setWorkoutParameter() {
        detailsTaimerView.exerciseLabel.text = workoutModel.workoutName
        detailsTaimerView.setsNumberLabel.text = " \(numberOfSet)/\(workoutModel.workoutSets)"
        let (min, sec) = workoutModel.workoutTimer.convertSecond()
        detailsTaimerView.timeNumberLabel.text = "\(min) min \(sec) sec"
        
        taimerTimeLabel.text = "\(min):\(sec.setZeroForSeconds())"
        durationTimer = workoutModel.workoutTimer
      
    }
    var tapLabel = UITapGestureRecognizer()
    private func addTaps() {
        tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        taimerTimeLabel.isUserInteractionEnabled = true //свойство отвечающее за разрешение взаимодействие с пользователем (мы разрешили)
        taimerTimeLabel.addGestureRecognizer(tapLabel) //добавили распознавание жестов для этого лабел
    }
    @objc private func startTimer() {
        detailsTaimerView.editingButton.isEnabled = false //кнопка будет неактивна пока таймер не дойдет до нуля
        detailsTaimerView.nextSetButton.isEnabled = false
        tapLabel.isEnabled = false
        if numberOfSet == workoutModel.workoutSets {
          alertOk(title: "Error", message: "You did  all the sets")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        }
        //Запуск анимации, анимация происходит при запуске таймера
         //каждую секунду будет выполняться метод timerAction
    }
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        if durationTimer == 0 {
            timer.invalidate() // invalidate - команда, которая останавливает таймер (сбрасывает)
            durationTimer = workoutModel.workoutTimer
            numberOfSet += 1
            detailsTaimerView.setsNumberLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
            detailsTaimerView.editingButton.isEnabled = true //когда таймер дойдет до нуля они будут активными
            detailsTaimerView.nextSetButton.isEnabled = true
            tapLabel.isEnabled = true
        }
        let (min, sec) = durationTimer.convertSecond()
        taimerTimeLabel.text = "\(min):\(sec.setZeroForSeconds())"
    }
}
//MARK: - extension Animation (анимация с кругом у таймера)
extension TaimerWorkoutViewController {
    private func animationCircular() {
        let center = CGPoint(x: taimerImageView.frame.width / 2, y: taimerImageView.frame.height / 2) //получаем центр нашей имедж
        
        let endAngle = (-CGFloat.pi / 2) //получаем коненчый угол, где будет заканчиваться анимация
        let startAngle = 2 * CGFloat.pi + endAngle //начальный угол как будет начинаться анимация
        let circularPath = UIBezierPath(arcCenter: center, radius: taimerImageView.frame.width * 0.45, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1 //это свойство означает, что наш бегунок будет идти к конечной точке
        shapeLayer.lineCap = .round //это свойство означает, что край этого бегунка будет не прямой, а закругленный
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        taimerImageView.layer.addSublayer(shapeLayer) //добавили бегунок на нашу картинку
//        view.frame.width * 0.27
    }
    private func basicAnimation() {
        let basikAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basikAnimation.toValue = 0 //значение с которым бегунок будет двигаться
        basikAnimation.duration  = CFTimeInterval(durationTimer) //продолжительность нашего таймера
        basikAnimation.fillMode = .forwards
        basikAnimation.isRemovedOnCompletion = true //свойство удаления и завершения анимации
        shapeLayer.add(basikAnimation, forKey: "basicAnimation")
    }
}
//MARK: - extension NextSetProtocol
extension TaimerWorkoutViewController: NextSetsProtocol {
    func editingTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Timer of set") { [self] sets, timerOfSet in
            if sets != "" && timerOfSet != "" {
            guard let numberOfSets = Int(sets) else { return }
            guard let numberOfTimer = Int(timerOfSet) else { return }
            detailsTaimerView.setsNumberLabel.text = "\(numberOfSet)/\(sets)"
            detailsTaimerView.timeNumberLabel.text = timerOfSet
            self.taimerTimeLabel.text = timerOfSet
            let (min, sec) = numberOfTimer.convertSecond()
            taimerTimeLabel.text = "\(min):\(sec.setZeroForSeconds())"
            durationTimer = numberOfTimer
            RealmManager.shared.updateSetsTaimerWorkoutModel(model: workoutModel, sets: numberOfSets, taimer: numberOfTimer ) //обновляем модель
            }
        }
    }
    
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1 //происходит увеличение счетчика
            detailsTaimerView.setsNumberLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOk(title: "Compele", message: "We finish your workout")
        }
    }
}
//MARK: - extension setConstrains

extension TaimerWorkoutViewController {
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
               
                taimerImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
                taimerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                taimerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                taimerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
            ])
            NSLayoutConstraint.activate([
               
                taimerTimeLabel.leadingAnchor.constraint(equalTo: taimerImageView.leadingAnchor, constant: 40),
                taimerTimeLabel.trailingAnchor.constraint(equalTo: taimerImageView.trailingAnchor, constant: -40),
                taimerTimeLabel.centerYAnchor.constraint(equalTo: taimerImageView.centerYAnchor)
               
            ])
            NSLayoutConstraint.activate([
                detailsLabel.topAnchor.constraint(equalTo: taimerImageView.bottomAnchor, constant: 30),
                detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            ])
            NSLayoutConstraint.activate([
                detailsTaimerView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
                detailsTaimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                detailsTaimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                detailsTaimerView.heightAnchor.constraint(equalToConstant: 230)
            
            ])
            NSLayoutConstraint.activate([
                finishButton.topAnchor.constraint(equalTo: detailsTaimerView.bottomAnchor, constant: 20),
                finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                finishButton.heightAnchor.constraint(equalToConstant: 55)
            
            ])

}
}
