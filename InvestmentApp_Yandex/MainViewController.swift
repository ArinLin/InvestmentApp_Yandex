//
//  ViewController.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 15.07.2023.
//

import UIKit

class MainViewController: BaseController {
//    private let navBar = CustomNavBarView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // регистрируем ячейку
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseID)
        
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
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
// МARK: Расширения для коллекции
// для получения данных
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        40
    }
    
    // метод возвращает ячейки для нашей коллекции
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        
        cell.configure(withTitle: "Yndx", subtitle: "Yandex, LLC", isFavourite: false)
        return cell
    }
}
 
// для настройки внешнего вида
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // для настройки размера ячейки
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width:collectionView.frame.width, height: 20) // ячейки такой же ширины, как и коллекция
    }
    
    // для настройки размера хедера
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        CGSize(width:collectionView.frame.width, height: 32)
//    }
}


