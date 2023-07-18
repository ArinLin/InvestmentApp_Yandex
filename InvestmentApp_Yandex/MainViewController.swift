//
//  ViewController.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 15.07.2023.
//

import UIKit
// изменение состояния для кнопки
extension MainViewController {
    public enum State {
        case stocksIsActiv
        case favsIsActiv
    }
}

class MainViewController: BaseController {
//    private let searchController = UISearchController(searchResultsController: nil)
    
    public var state = State.stocksIsActiv
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.minimumLineSpacing = 8

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .blue//.clear

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .green
        addViews()
        configure()
        layoutViews()
    }
}

// у нас есть baseController, в котором мы определили базовые методы
extension MainViewController {
    override func addViews() {
        super.addViews()
//        view.addSubview(navBar)
        view.addSubview(collectionView)
    }
    override func configure() {
        super.configure()
        // для того, чтобы спрятать верхнюю линию
        navigationController?.navigationBar.isHidden = true
        
//        //Настройка делегата UISearchController для обработки результатов поиска и других событий:
//        searchController.searchResultsUpdater = self
//        searchController.delegate = self
//        // Настройка и дополнительные параметры UISearchController
//        searchController.obscuresBackgroundDuringPresentation = false //searchController не позволяет взаимодействовать с отображаемым контентом, он его просто затемняет. Чтобы мы смогли работать с отфильтрованным контентом, как с основным -- присваиваем false
//        searchController.searchBar.placeholder = "Find company or ticker"
//        searchController.searchBar.searchBarStyle = .minimal
//        // Установка searchController как navigationItem.searchController нашего view controller'а:
//        navigationItem.searchController = searchController // тем самым отобразим строку поиска на навишейшн баре
        
        // регистрируем ячейку
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseID)
        // регистрируем хедер через forSupplementaryViewOfKind
        collectionView.register(CompanyHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CompanyHeader.reuseID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.reloadData()
        
//        navBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutViews() {
        super.layoutViews()
        NSLayoutConstraint.activate([
//            navBar.topAnchor.constraint(equalTo: view.topAnchor),
//            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
//MARK: - Расширения для коллекции

// для получения данных
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    // метод возвращает ячейки для нашей коллекции
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        
        cell.configure(withTitle: "Yndx", subtitle: "Yandex, LLC", isFavourite: false)
        cell.layer.cornerRadius = 16 
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CompanyHeader.reuseID, for: indexPath) as? CompanyHeader else {
            fatalError("Unable to dequeue HeaderView")
        }
        
        // Конфигурируем кнопки
        headerView.stocksButton.setTitle("Stoks", for: .normal)
        headerView.stocksButton.addTarget(self, action: #selector(CompanyHeader.stocksButtonTapped), for: .touchUpInside)
        
        headerView.favsButton.setTitle("Favourites", for: .normal)
        headerView.favsButton.addTarget(self, action: #selector(CompanyHeader.favsButtonTapped), for: .touchUpInside)
        
        return headerView
    }
}
 
// для настройки внешнего вида
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // для настройки размера ячейки
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 328, height: 68)
//        CGSize(width:collectionView.frame.width, height: 60) // ячейки такой же ширины, как и коллекция
    }
    
    // для настройки размера хедера
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: 207, height: 72)
//        CGSize(width:collectionView.frame.width, height: 32)
    }
}

//MARK: - Настройка кнопок
//extension MainViewController {
//    @IBAction func stocksButtonTapped() {
//        if state == .favsIsActiv {
//            state = .stocksIsActiv
//            print("Кнопка стокс нажата")
//        }
//    }
//
//    @IBAction func favsButtonTapped() {
//        if state == .stocksIsActiv {
//            state = .favsIsActiv
//            print("Кнопка любимое нажата")
//        }
//    }
    
//    func animateStateSetting() {
//        let activeButton = state == .stocksIsActiv ? .stocksButton : favsButton
//    }
//}

//MARK: - Расширения для серч контроллера

//extension MainViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
//}
//
//
//extension MainViewController: UISearchControllerDelegate {
//
//}
