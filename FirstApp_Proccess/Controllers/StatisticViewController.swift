//
//  StatisticViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 22.01.2022.
//

import UIKit
import RealmSwift

struct DifferenceWorkout {
    let name: String
    let lastReps: Int
    let firstReps: Int
}
class StatisticViewController: UIViewController {

    private let statisticLabel: UILabel = {
        let label = UILabel()
         label.text = "STATISTICS"
         label.font = .robotoMedium24()
         label.textColor = .specialGray
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 16)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font as Any,
                                                 NSAttributedString.Key.foregroundColor: UIColor.specialGray],
                                                for: .selected)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    } ()

    
    private let exersisesLabel = UILabel(text: "Exersises")
    //MARK: - Создание textField
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialBrown
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
  
    //MARK: - Создание tableView
    private let statisticTableView: UITableView = {
      let tableView = UITableView()
        tableView.backgroundColor = .none
         tableView.separatorStyle = .none //разделяющие линии убрали
        tableView.bounces = false //чтобы не оттягивалось
        tableView.showsVerticalScrollIndicator = false //не показывает скролл индикатор
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()
    private let idStatisticsTableViewCell = "idStatisticsTableViewCell"
    //MARK: - Работа с Realm
    let localRealm = try! Realm()
    var workoutArray: Results<WorkoutModel>!
    //MARK: - Массив структуры
     private var differenceArray = [DifferenceWorkout]()
     private var filtredArray = [DifferenceWorkout]()
    //MARK: - Работа с датой
    let dateToday = Date().localDate()
    private var isFiltred = false
    //MARK: - viewWillAppear - запускается перед тем как VC будет отображен на экране. Для обновления табицы
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        statisticTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       setupViews()
       setConstrains()
       setDelegates()
       setStartScreen()
        
    }
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabel)
        view.addSubview(segmentedControl)
        view.addSubview(exersisesLabel)
        view.addSubview(statisticTableView)
        view.addSubview(nameTextField)
        statisticTableView.register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticsTableViewCell) //зарегистрировали ячейку

    }
    private func setDelegates() {
        statisticTableView.delegate = self
        statisticTableView.dataSource = self
        nameTextField.delegate = self
    }
    private func setStartScreen() {
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 7))
        statisticTableView.reloadData()
    }
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
          differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offsetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
            statisticTableView.reloadData()
        } else {
            differenceArray = [DifferenceWorkout]()
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
            statisticTableView.reloadData()
        }
    }
    private func getWorkoutsName() -> [String] {
        var nameArray = [String] () //пустой массив
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) { //если nameArray не содрежит такого имени тогда добавь
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps, //последний  репс который мы сделали
                  let first = workoutArray.first?.workoutReps else { //в начале
                      return
                  }
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first) //создали экземпляр стурктуры
            differenceArray.append(differenceWorkout) //добавили этот экзепляр в difference массив
        }
    }
    private func filtringWorkout(text: String) {
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()) { //если элемент массива содержит текст, который мы ввели в текстФилд и перевели весь текст в нижний регистр
                filtredArray.append(workout)
            }
               
        }
    }
} //закрывает класс
//MARK: - UITextFieldDelegate
extension StatisticViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { //будем ли мы заменять текст, который текст в текстФилде, если тру то будем
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: textRange, with: string) //для отображения корректного текста без запаздывания
            filtredArray = [DifferenceWorkout]() //чтобы значения обновлялись
            filtringWorkout(text: updateText)
            isFiltred = (updateText.count > 0 ? true : false )//если updateText содержит значения, возвращаем тру, если путой фолс
            statisticTableView.reloadData() //обновляем таблицу
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isFiltred = false
        differenceArray = [DifferenceWorkout]() //очищаем  массив для того чтобы не было повтора записей (если вызвать этот метод без обнуления массива, наши записи будут плюсоваться и увеличиваться)
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 7)) //заполняем массив новыми данными за 7 дней
        statisticTableView.reloadData()
        return true
    }
    
}
//MARK: - UITableViewDataSource
extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count: differenceArray.count //если isFiltred тру тогда возвращаем filtredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticsTableViewCell, for: indexPath) as! StatisticTableViewCell
        let differenceModel = (isFiltred ? filtredArray[indexPath.row] : differenceArray[indexPath.row]) //для конфигурирования ячейки
        cell.cellConfigure(differenceWorkout: differenceModel)
        return cell
    }
    
    
}
extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
}



extension StatisticViewController {
    private func setConstrains() { //метод для констреинтов
        NSLayoutConstraint.activate([
            statisticLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         
        ])
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: statisticLabel.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
         
        ])
        NSLayoutConstraint.activate([
            exersisesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            exersisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exersisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
         
        ])
        NSLayoutConstraint.activate([
            statisticTableView.topAnchor.constraint(equalTo: exersisesLabel.bottomAnchor, constant: 0),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            statisticTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        ])
        
  }
}
