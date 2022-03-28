//
//  CalendarView.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 15.01.2022.
//

import UIKit
protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(date: Date) //будет метод в который мы будем передавать date типа Даты
}
class CalendarView: UIView {
    
    private let collectionCalendarView: UICollectionView =  {
       let layout = UICollectionViewFlowLayout() //забыл написать Flow 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    } ()
    private let weekDaysList = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat",]
    private let idCalendarCell = "idCalendarCell" //создали индентификатор
    //MARK: - Создаем слабую сслыку
    weak var cellCollectionViewDelegate: SelectCollectionViewItemProtocol?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
        setDelegates()
        
        collectionCalendarView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell) //регистрация ячейки
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - Метод setupViews()
    private func setupViews() {
        backgroundColor = .specialGreen //установили цвет
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionCalendarView)
        
    }
//MARK: - Метод setDelegates()
        //управленцем будем мы сами
    private func setDelegates() {
        collectionCalendarView.delegate = self //этим будет выполнять наша вьюха
        collectionCalendarView.dataSource = self
    }
  
    private func weekArray() -> [[String]] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")//то что будует английская локализация
        dateFormatter.dateFormat = "EEEEEE" //в каком формате будет выводится
        
        var weekArray : [[String]] = [[],[]] //создаем двумерный массив (в один массив будем закидывать названия дней недели в другой массив числа)
        let calendar = Calendar.current //берем установленный календарь (текущий)
        let today = Date() //получаем сегоднящнюю дату (происходит инициализация)
        
        for i in -6...0 { //6 предыдущих значений это 6 предыдущих дней
            let date = calendar.date(byAdding: .weekday, value: i, to: today)
            print(date ?? Data())//будет выводится дата дня недели
            guard let date = date else { return weekArray }
            let components = calendar.dateComponents([.day], from: date)
            print(components) //будет выводится число дня недели
            weekArray[1].append(String(components.day ?? 0))
            let weekDay = dateFormatter.string(from: date)
            weekArray[0].append(String(weekDay))
        }
        return weekArray
    }
}//закрывает класс

//MARK: - Делаем расширение,  в котором мы подписываемся на протокол UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7 //устанавливаем значение 7 - так как кол-во item у нас 7. Пишем их количество
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { //тут мы создаем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as! CalendarCollectionViewCell //это ячейка переиспользуемая
        cell.cellConfigure(weekArray: weekArray(), indexPath: indexPath)
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right) //этот метод находится в ячейке!!!
        }
        return cell
    }
}
//MARK: -  Делаем расширение,  в котором мы подписываемся на протокол UICollectionViewDelegate
extension CalendarView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //этот метод отрабатывает, когда мы нажимаем на какую-нибудь ячейку
        let calendar =  Calendar.current //создаем календарь текущий
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let components = calendar.dateComponents([.month, .year], from: Date()) //выбираем weekDay - номер дня и выбираем его из date - которая будет нам прихоидить  во входные параметры
        guard let month = components.month else { return }
        guard let year = components.year else { return }//если мы его получим код ниже, если нет выполниться в скобках (получаем день недели)
       
         guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else { return }  //indexPath - мы берем из метода
         guard let numberOfDayString = cell.numberOfDayLabel.text else { return }
         guard let numberOfDay = Int(numberOfDayString) else { return }
         guard let date = formatter.date(from: "\(year)/\(month)/\(numberOfDay) 00:00") else { return }
        
         cellCollectionViewDelegate?.selectItem(date: date)
     
//       
    }
}
//MARK: - UICollectionViewDelegateFlowLayout (Размер ячейки и Интервал между ячейками)
extension CalendarView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { //Здесь назначаем размер яейки
        CGSize(width: 34, height:
                collectionView.frame.height) //ширина 34, а высота такая же как у collectView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
}

//MARK: - setConstrains()
extension CalendarView {
    
        private func setConstrains() {
            
            NSLayoutConstraint.activate([
                collectionCalendarView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                collectionCalendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 105),
                collectionCalendarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                collectionCalendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            ])
        }
}


