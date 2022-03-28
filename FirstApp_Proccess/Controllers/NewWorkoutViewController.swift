//
//  NewWorkoutViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 18.01.2022.
//

import UIKit
import RealmSwift
class NewWorkoutViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.delaysContentTouches = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let newWorkoutLabel: UILabel = {
      let label = UILabel()
        label.text = "NEW WORKOUT"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center //выравнивание текста (сделал по центру)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "CloseButton"), for: .normal) //установка изображения
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
     return button
    } ()
    @objc private func closeButtonTapped() { //данный метод для кнопки закрытия. которая закрывает эту вью и выгружает ее из памяти
       dismiss(animated: true, completion: nil)
        print("View закртыта и выгружена из памяти")
    }
    
    private let namedLabel = UILabel(text: "Name")
    
    private let nameTextField: UITextField = {
      let textFild = UITextField()
        textFild.backgroundColor = .specialBrown
        textFild.borderStyle = .none // свойство - стиль границы
        textFild.layer.cornerRadius = 10
        textFild.textColor = .specialGray
        textFild.font = .robotoBold20()
        textFild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textFild.frame.height)) //  - добавляется маленькая (шириной 15 поинтов) прозрачная вью для того чтобы текст вводился не по самой левой границе
        textFild.leftViewMode = .always // это свойство leftViewMode устновленное в always - говорит нам о том что мы это вьюху показываем всегда (always - всегда)
        textFild.clearButtonMode = .always // это свойство clearButtonMode установленное в always - это свойство  при вводе текста появляется кнопочка, при помощи которой можно очистить textFild
        textFild.returnKeyType = .done //это свойство  returnKeyTypе (для клавиатуры) - установили ее в done - сдесь можно делать доп настройки у клавиатуры
        textFild.translatesAutoresizingMaskIntoConstraints = false
    return textFild
    } ()
    
    
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    
    //MARK: - DateAndRepeatView()
    private let dateAndRepeatView = DateAndRepeatView()
    
    
    private let repsOrTimerLabel = UILabel(text: "Reps or timer")
    
    //MARK: - RepsOrTimerView()
   private let repsOrTimerView = RepsAndTimerView()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    } ()
    @objc private func  saveButtonTapped() {
        print("saveButtonTapped")
        setModel()
        saveModel()
        print(workoutModel)
    }
    //MARK: - Работа с Realm
    private let localRealm = try! Realm()
    private var workoutModel = WorkoutModel()//создаем модель
    
    private let testImage = UIImage(named: "imageTraningCell")
  
    //MARK: - Метод viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2 //перерисовываем и скругляем нашу кнопку в зависимости от ее высоты
//        print(dateAndRepeatView.frame.height)
    }
    //MARK: - Метод viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Вызов методов:
         setupViews()
         setConstrains()
         setDelegate()
         addTaps()
        
    }
  
    //MARK: - setupViews метод, который установка элементы на View
    private func setupViews() { // в этом методе мы будем делать настройки для наших View
        view.backgroundColor = .specialBackground //Создали фон для всей view
        view.addSubview(scrollView)
        view.addSubview(newWorkoutLabel)
        view.addSubview(namedLabel)
        view.addSubview(closeButton)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatLabel)
        view.addSubview(dateAndRepeatView)
        view.addSubview(repsOrTimerLabel)
        view.addSubview(repsOrTimerView)
        view.addSubview(saveButton)
    }
    //MARK: - setDelegate() установка делегата для textFild
    private func setDelegate() {
        nameTextField.delegate = self
    }
    
    //MARK: - Метод для закрытия клавиатуры по тапу на экран
    //метод регистрирующий нажатия на экран
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)) //UITapGestureRecognizer - Отслеживает все тапы с экрана
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    //Метод для спрятывания клавиатруы
    @objc private func hideKeyboard() {
        view.endEditing(true) //endEditing - закончить редактирование
    }
    //MARK: - SetModel() - собираем модель
    private func setModel() {
        guard let nameWorkout = nameTextField.text else { print("Error"); return }
        workoutModel.workoutName = nameWorkout //получаем имя
        workoutModel.workoutDate = dateAndRepeatView.datePicker.date //получаем дату, но нам нужно еще получить номер дня в неделе
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: dateAndRepeatView.datePicker.date)
        guard let weekday = components.weekday else { return } //получили  номер деня недели
        workoutModel.workoutNumberOfDay = weekday
        
        workoutModel.workoutRepeat = (dateAndRepeatView.repeatSwitch.isOn) //сохраняем в свойство workoutRepeat из workoutModel значение свитча из dateAndRepeatView
        workoutModel.workoutSets = Int(repsOrTimerView.setsSlider.value)
        workoutModel.workoutReps = Int(repsOrTimerView.repsSlider.value)
        workoutModel.workoutTimer = Int(repsOrTimerView.timerSlider.value)
        
        guard let imageData = testImage?.pngData() else { return } //установка тестовой картинки
        workoutModel.workoutImage = imageData
    }
    //MARK: - saveModel() - сохраняем модель (Проверки)
    private func saveModel() {
        guard let text = nameTextField.text else { return } //достаем текст из текст филда
        let count = text.filter { $0.isNumber || $0.isLetter}.count //если в строке содержкится символ или цифра (считает ихк количество) пробелы не считаются
        if count != 0 && workoutModel.workoutSets != 0 && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            createNotification() //когда сохраняем модель будет вызываться метод для уведомлений
            alertOk(title: "Success", message: nil)
            workoutModel = WorkoutModel()
            refreshWorkoutObject()
        } else  { //будем выводить алетр
            alertOk(title: "Error", message: "Enter all parameters") //вызов Алерта (Enter all parameters - введите все параметры)
        }
        
    }
    //MARK: - refreshWorkoutObject
    private func refreshWorkoutObject() {
        dateAndRepeatView.datePicker.setDate(Date(), animated: true)
        nameTextField.text = ""
        dateAndRepeatView.repeatSwitch.isOn = true
        repsOrTimerView.numberOfSetLabel.text = ""
        repsOrTimerView.setsSlider.value = 0
        repsOrTimerView.numberOfRepsLabel.text = ""
        repsOrTimerView.repsSlider.value = 0
        repsOrTimerView.numberOfTimerLabel.text = ""
        repsOrTimerView.timerSlider.value = 0
    }
    //MARK: - createNotification
    private func createNotification() {
        let notification = Notifications()
        let stringDate = workoutModel.workoutDate.ddMMyyyyFromDate()
        print(workoutModel.workoutDate)
        notification.scheduleDateNotification(date: workoutModel.workoutDate, id: "workout" + stringDate)
    }
} //Закрывает класс
//MARK: - Расширение delegate - для текст Филда. Чтобы закрывалась клавиатура после ввода текста в тексФилд и нажития на кнопку Done
extension NewWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}
//MARK: - Constrains - привязки
//Сделаем расширение для NewWorkoutViewController
extension NewWorkoutViewController {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для newWorkoutLabel
            newWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для closeButton
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для namedLabel
            namedLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 10),
            namedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            namedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для nameTextFild
            nameTextField.topAnchor.constraint(equalTo: namedLabel.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для dateAndRepeatLabel
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для dateAndRepeatView
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 94)
            //dateAndRepeatView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
            
        
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для dateAndRepeatView
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для repsOrTimerView
            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 320)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для saveButton
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])

        
    }
}
