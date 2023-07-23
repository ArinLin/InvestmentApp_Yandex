//
//  ViewController.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 15.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let buttons = ButtonsView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout ()
        layout.minimumLineSpacing = 8

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
//        view.backgroundColor = .blue//.clear

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = .green
        collectionView.backgroundColor = Resourses.Colors.background
        addViews()
        setupDelegate()
        setNavigationBar()
        setupSearchController()
        configure()
        layoutViews()
    }
}

extension MainViewController {
    func addViews() {
//        view.backgroundColor = .blue
        view.backgroundColor = Resourses.Colors.background
        view.addSubview(buttons)
        view.addSubview(collectionView)
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
//            navigationItem.title = "Test test"

            navigationItem.searchController = searchController
        }

        private func setupSearchController() {
            searchController.searchBar.placeholder = "Find company or ticker"
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.searchTextField.layer.borderWidth = 1.0
            searchController.searchBar.searchTextField.layer.borderColor = UIColor.black.cgColor
            searchController.searchBar.searchTextField.layer.cornerRadius = 18
        }
    
    func configure() {
        // регистрируем ячейку
        collectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.reuseID)
        // регистрируем хедер через forSupplementaryViewOfKind
//        collectionView.register(CompanyHeader.self,
//                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                withReuseIdentifier: CompanyHeader.reuseID)
        
        collectionView.reloadData()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        buttons.translatesAutoresizingMaskIntoConstraints = false
//        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([            
//            searchBarContainer.widthAnchor.constraint(equalToConstant: 328).isActive = true
//            searchBarContainer.heightAnchor.constraint(equalToConstant: 48).isActive = true
            
            buttons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            buttons.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttons.heightAnchor.constraint(equalToConstant: 32),
            buttons.widthAnchor.constraint(equalToConstant: 207),
            
            collectionView.topAnchor.constraint(equalTo: buttons.bottomAnchor, constant: 10),
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.reuseID, for: indexPath) as? CompanyCell else { return UICollectionViewCell() }
        
        if indexPath.item % 2 == 0 {
                // Если индекс четный, задаем один цвет фона
            cell.backgroundColor = Resourses.Colors.grayCell
            } else {
                // Если индекс нечетный, задаем другой цвет фона
                cell.backgroundColor = .clear
            }
        
        cell.configure(withTitle: "Yndx", subtitle: "Yandex, LLC", isFavourite: false)
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 16 
        cell.layer.masksToBounds = true
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CompanyHeader.reuseID, for: indexPath) as? CompanyHeader else {
//            fatalError("Unable to dequeue HeaderView")
//        }
//
//        // Конфигурируем кнопки
//        headerView.stocksButton.setTitle("Stoks", for: .normal)
//        headerView.stocksButton.addTarget(CompanyHeader(), action: #selector(CompanyHeader.stocksButtonTapped), for: .touchUpInside)
//
//        headerView.favsButton.setTitle("Favourites", for: .normal)
//        headerView.favsButton.addTarget(CompanyHeader(), action: #selector(CompanyHeader.favsButtonTapped), for: .touchUpInside)
//
//        return headerView
//    }
}
 
// для настройки внешнего вида
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // для настройки размера ячейки
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 328, height: 68)
    }
    
    // для настройки размера хедера
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        CGSize(width: 207, height: 72)
//    }
}

//MARK: - Расширения для серч контроллера

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print(searchText)
        }
}

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
