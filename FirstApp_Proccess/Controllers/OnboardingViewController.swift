//
//  OnboardingViewController.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 10.02.2022.
//

import UIKit
struct OnboardingStruct {
    let topLabel: String
    let bottomLabel: String
    let image: UIImage
}
class OnboardingViewController: UIViewController {
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = .robotoBold20()
        button.tintColor = .specialGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) //трансформируем делаем больше в полтора раза
        pageControl.isEnabled = false //выключили его
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    } ()
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout() //cоздали макет
        layout.minimumLineSpacing = 0 //расстояние между ними будет 0
        layout.scrollDirection = .horizontal //скроитьь будем по горизонтали
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let idOnboardingCell = "idOnboardingCell" //для инициализации ячейки
    private var onboardingArray = [OnboardingStruct]()
    private var collectionItem = 0
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
         setupViews()
         setConstraints()
         setDelegtes()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialGreen

        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: idOnboardingCell) //регистрируем ячейку
        
        guard let imageFirst = UIImage(named: "onboardingFirst"),
              let imageSecond = UIImage(named: "onboardingSecond"),
              let imageThird = UIImage(named: "onboardingThird")
              else { return }
        let firstScreen = OnboardingStruct(topLabel: "Have a good health",
                                          bottomLabel: "Being healthy is all, no health is nothing. So why do not we",
                                          image: imageFirst)
        let secondScreen = OnboardingStruct(topLabel: "Be stronger",
                                            bottomLabel: "Take 30 minutes of bodybuilding every day to get physically fit and healthy.",
                                            image: imageSecond)
        let thirdScreen = OnboardingStruct(topLabel: "Have nice body",
                                           bottomLabel: "Bad body shape, poor sleep, lack of strength, weight gain, weak bones, easily traumatized body, depressed, stressed, poor metabolism, poor resistance",
                                           image: imageThird)
        onboardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    private func setDelegtes() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func nextButtonTapped() {
        if collectionItem == 1 {
            nextButton.setTitle("START", for: .normal)
        }
        if collectionItem == 2 {
            saveUserDefaults()
        } else {
            collectionItem += 1
            let index: IndexPath = [0, collectionItem]
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem // чтобы менялся pageControl на текущее значение collectionItem
        }
    }
    private func saveUserDefaults() { //метод который сохраняет пользовательские параметры по умолчанию
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed") //установить пользовательские настройки по умолчанию
        dismiss(animated: true, completion: nil) //удаляет и скрывает экран
    }
} //закрывает класс
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnboardingCell, for: indexPath) as! OnboardingCollectionViewCell
        let model = onboardingArray[indexPath.row]
         cell.cellConfigure(model: model)
        return cell
        
    }
  
}
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height) //настраиваем как будет выглядеить эта коллетион вью (она будет по ширине всего экрана а по высоте как коллектион вью
    }
}
extension OnboardingViewController {
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
        ])
    }
}
