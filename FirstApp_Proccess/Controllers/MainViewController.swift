//
//  ViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 14.01.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
//MARK: - Создание ImageView (одновременное создание и придание свойств)
    
    private let userPhotoImageView: UIImageView = { //создаем первый элемент - это ImageView(аватарка польз)
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1) //цвет заднего фона
        imageView.layer.borderWidth = 5 // ширина обводки
        imageView.layer.borderColor = UIColor.white.cgColor //назначаем цвет обводки (тип cgColor)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false //тамика в фолс (констреинты будем сами прописывать)
       return imageView
    } ()
    
    //MARK: - Создание calendarView: UIView (одновременное создание и придание свойств)
    private let calendarView = CalendarView()
    
    //MARK: - Создание label(Имя пользователя): UILabel (одновременное создание и придание свойств)
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "USER"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true // свойство - которое, уменьшает шрифт в зависимости от ширины label
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2 //свойство - которое уменьшает шрифт (шрифт на 30 % , на 50%)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    //MARK: - Создание label workoutTodayLabel
    private let workoutToDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout today"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        label.adjustsFontSizeToFitWidth = true 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    //MARK: - Создание addWorkoutButton (Создание кнопки)
    private let addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "addWorkout"), for: .normal) //добавляем Image из Assets
        button.setTitle("Add Workout", for: .normal) //добавляем заголовок, стиль нормал
        button.titleLabel?.font = .robotoMedium12() //добавляем шрифт к нашему заголовку
        button.tintColor = .specialDarkGreen // подцвечивать цветом наш текст и Image
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.addShadowOnView() //вызываем метод из расширения UIView + Extensions для добавления тени кнопке
        button.setImage(UIImage(named: "addWorkout"), for: .normal) //добавляем Image из Assets
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside) //действие кнопки
        return button
    } ()
   
    //MARK: - Создание weatherView
    let weatherView = WeatherView()
   
    //MARK: - Создание ImageView NoTraning
    private let noTraningImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.image = UIImage(named: "noTraning") //добавил картинку no traning
        imageView.contentMode = .scaleAspectFit //Возможность масштабировать содержимое в соответствии с размером представления, сохраняя соотношение сторон.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true // свойство, которое позволяет скрывать view. Эта вью сейчас скрыта
      return imageView
    } ()

    //MARK: - Создание tableView
    private let tableView: UITableView = {
      let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none //разделяющие линии убрали
        tableView.bounces = false //чтобы не оттягивалось
        tableView.showsVerticalScrollIndicator = false //не показывает скролл индикатор
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.isHidden = true
        return tableView
    } ()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    //MARK: - Работа с Realm
    private let localRealm = try! Realm() // создали экземпляр класса реалм
    private var workoutArray: Results <WorkoutModel>!  //будет приходить массив, и каждый элемент массива будет представлять WorkoutModel
    private var userArray: Results <ProfileModel>!
    
    //MARK: - viewDidLayoutSubviews - перерисовка subView (ЖЦ)
    override func viewDidLayoutSubviews() { //перерисовывает
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2 // делаем круг и перерисовываем его

    }
    //MARK: - viewWillAppear - запускается перед тем как VC будет отображен на экране. Для обновления табицы
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        setupUserParemeters()
        getWeather()
        
    }
    //MARK: - viewDidAppear (//запускается после поялвления добавлени вью в иерархию вью
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showOnboarding()
    }
    //MARK: - viewDidLoad - загрузка View (ЖЦ)
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray = localRealm.objects(ProfileModel.self)
        setupViews() //вызываем метод настройки View
        setConstrains() //вызываем метод с констреинтами
        setDelegate() //вызываем метод setDelegate()
        setupUserParemeters()
        getWorkouts(date: Date()) //вызываем метод и  подставляем сегоднящнюю дату в метод
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
        getWeather()
    }
    
    
    //MARK: - setDelegate()
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    
    //MARK: - Установка элементов на View
    private func setupViews() { // в этом методе мы будем делать настройки для наших View
      
        view.backgroundColor = .specialBackground
        
        view.addSubview(calendarView) //добавили календарь view
        view.addSubview(userPhotoImageView) //добавили фотку на основную view
        view.addSubview(userNameLabel) //добавили label с именем пользователя на view
        view.addSubview(addWorkoutButton) //добавили кнопку
        view.addSubview(weatherView) //добавили view с погодой
        view.addSubview(workoutToDayLabel) //добавил WorkoutToDayLabel
        view.addSubview(noTraningImageView)//добавил noTraning
        view.addSubview(tableView)//добавил tableView
    
    }
   
    //MARK: - Метод для действия кнопки addWorkoutButtonTapped (переход на WVC)
    @objc private func addWorkoutButtonTapped() {
        print("addWorkoutButtonTapped")
        let newWorkoutViewController = NewWorkoutViewController() //создали экземпляр класса NewWorkoutViewController, к которому будем осуществлять переход
        newWorkoutViewController.modalPresentationStyle = .fullScreen // что это
        present(newWorkoutViewController, animated: true) //осущесвляет переход
    }
    
    //MARK: -  setupUserParemeters Метод установки параметров пользователя
    private func setupUserParemeters() {
        if userArray.count != 0 {
            userNameLabel.text = userArray[0].userFirstName + " "  + userArray[0].userSecondName
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
        }
    }
    
    //MARK: - Метод для получения даты. Для отображения тренировок
    private func getWorkouts(date: Date) {
        let calendar =  Calendar.current //создаем календарь текущий
        let formatter = DateFormatter()
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date) //выбираем weekDay - номер дня и выбираем его из date - которая будет нам прихоидить  во входные параметры
        guard let weekday = components.weekday else { return }
        guard let day = components.day else { return }
        guard let month = components.month else { return }
        guard let year = components.year else { return }//если мы его получим код ниже, если нет выполниться в скобках (получаем день недели)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        guard let dateStart = formatter.date(from: "\(year)/\(month)/\(day) 00:00") else { return }
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
        }()
       
        //Создание ПРЕДИКАТА - УСЛОВИЕ по которому делается запрос в БД (Условия фильра)
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")//тут если упражение повторяется допустим каждый четверг
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd]) //такой синтаксис. Если у нас упражение не повторяется, но оно подходит под сегоднящнюю дату тогда мы помещаем ее в табицу
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])//or - или
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")  //мы тут получаем данные и хотим их отфильтровать. Для этого мы указываем предикат. И фильруем их по имени.
        checkWorkoutsToday()
        tableView.reloadData() //когда мы будем менять дату нам нужно перезагружать таблицу
        
    }
    private func checkWorkoutsToday() {
        if workoutArray.count == 0 { 
            tableView.isHidden = true
            noTraningImageView.isHidden = false
        } else {
            tableView.isHidden = false
            noTraningImageView.isHidden = true
        }
    }
    private func showOnboarding() {
        let userDefaults = UserDefaults.standard
        let onBoardingWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed") //было просмотрено?
        if onBoardingWasViewed == false { //если он не был просмотрен
             let onboardingVC = OnboardingViewController()
            onboardingVC.modalPresentationStyle = .fullScreen //показывать на весь экран
            present(onboardingVC, animated: false)
        }
    }
    //MARK: - getWeather()
    private func getWeather() {
        NetworkDataFetch.shared.fetchWeather {[weak self] model, error in //слабая сслыка
            guard let self = self else { return }
            if error == nil {
                guard let model = model else { return }
                self.weatherView.weatherStatusLabel.text = "\(model.conditionString) \(model.temperture)°C  \(Int(model.windSpeed))м/с "
                self.weatherView.actionWeatherLabel.text = model.conditionStringTraning
                let imageIcon = model.iconCode
                self.weatherView.sunImageView.image = UIImage(named: imageIcon)
            } else {
                self.alertOk(title: "Error", message: "No weather data")
            }
        }
    }
} //закрывает класс
//MARK: - Расширение StartWorkoutProtocol
extension MainViewController: StartWorkoutProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
        let startWorkoutViewController = StartWorkoutViewController()
        startWorkoutViewController.modalPresentationStyle = .fullScreen //открытие на полный экран
            startWorkoutViewController.workoutModel = model
        present(startWorkoutViewController, animated: true) //переход на startWorkoutViewController
        } else {
            let taimerWorkoutViewController = TaimerWorkoutViewController()
            taimerWorkoutViewController.modalPresentationStyle = .fullScreen
            taimerWorkoutViewController.workoutModel = model
            present(taimerWorkoutViewController, animated: true)
            }
       }
}
//MARK: - Расширение SelectCollectionViewItemProtocol
extension MainViewController: SelectCollectionViewItemProtocol {
    func selectItem(date: Date) {
        getWorkouts(date: date)
    }
    
    
}
//MARK: - Расширение UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       workoutArray.count //сколько записей будет в массиве столько и будет ячеек
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as! WorkoutTableViewCell
        let model = workoutArray[indexPath.row] //по каждой ячейке мы будем выбирать из нашего массива
        cell.cellConfigure(model: model) //передаем в ячейку модель
        cell.cellStartWorkoutDelegate = self
        return cell //возвращаем ячейку
    }
}

//MARK: - Расширение UITableViewDelegate
extension MainViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100 //установили ширину ячейки
        
    }
    //Метод для удаления или форматирования ячейки из таблицы
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? { //
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.reloadData()
        }
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//MARK: - Constrains - привязки
//Сделаем расширение для MainViewController
extension MainViewController {
    private func setConstrains() { //метод для констреинтов
        NSLayoutConstraint.activate([
            //Контсреинты для userPhotoImageView
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)

        
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для calendarView
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70)

        
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для userNameLabel
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для addWorkoutButton
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для weatherView
            weatherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weatherView.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для workoutTodayLabel
            workoutToDayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutToDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            noTraningImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noTraningImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noTraningImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            noTraningImageView.topAnchor.constraint(equalTo: workoutToDayLabel.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            //Контсреинты для tableView
            tableView.topAnchor.constraint(equalTo: workoutToDayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
          
        ])

    }
}


