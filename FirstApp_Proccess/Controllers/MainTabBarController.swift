//
//  MainTabBarController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 22.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() { //Настроили полоску
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen// для инконок активности (которые выбраны)
        tabBar.unselectedItemTintColor = .specialGray //цвет того элемента, который не выбран
        tabBar.layer.borderWidth = 1 // обводка внешняя
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
        
    }
    private func setupItems() { //Настроили иконку
        //Создаем ссылки (экземпляры классов ВьюКонтроллеров)
       let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        let profileVC = ProfileViewController()
        
        setViewControllers([mainVC, statisticVC,profileVC], animated: true) //Тут устанавливаем
        //Проверяем гардом на опциональность если значение есть код внутри скобок не выполняется и идет дальше
        guard let items = tabBar.items else { return }
        //Устанавливаем заголовок
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"
        //устанавливаем изображения
        items[0].image = UIImage(named: "tabBarMain")
        items[1].image = UIImage(named: "tabBarStatistic")
        items[2].image = UIImage(named: "tabBarProfile")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 12) as Any], for: .normal)
    }
    
}
