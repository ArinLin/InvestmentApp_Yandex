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
    
    var stocks = [StockDataCollection]()
    var timer: Timer?
    
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
    
    private func fetchStocks(stockName: String) {
//        let urlString = "https://finnhub.io/api/v1/stock/profile2?symbol=\(stockName)&token=cinvd89r01qhd71bkhk0cinvd89r01qhd71bkhkg"
        
        let urlString = "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=cinvd89r01qhd71bkhk0cinvd89r01qhd71bkhkg"
        
        NetworkDataFetch.shared.fetchStock(urlString: urlString) { [weak self] allStocks, error in
            if error == nil {
                guard let stocks = allStocks else { return }
                
                self?.stocks = stocks
                print(self?.stocks)
                self?.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
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
            buttons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttons.heightAnchor.constraint(equalToConstant: 32),
            buttons.widthAnchor.constraint(equalToConstant: 250),
            
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
        stocks.count
    }
    // дебаундс?? таймер когда пользователь вводит
    // метод возвращает ячейки для нашей коллекции
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.reuseID, for: indexPath) as? CompanyCell else { return UICollectionViewCell() }
        
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = Resourses.Colors.grayCell
            } else {
                cell.backgroundColor = .clear
            }
        
        let stock = stocks[indexPath.row]
        cell.configureStockCell(stock: stock)
        
//        cell.configure(withTitle: "Yndx", subtitle: "Yandex, LLC", isFavourite: false)
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 16 
        cell.layer.masksToBounds = true
        return cell
    }
}
 
// для настройки внешнего вида
extension MainViewController: UICollectionViewDelegateFlowLayout {
    // для настройки размера ячейки
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 328, height: 68)
        CGSize(width: 360, height: 68)
    }
}

//MARK: - Расширения для серч контроллера

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                self?.fetchStocks(stockName: text!)
            }
        }
        
//        if text != "" {
//            self.fetchStocks(stockName: text!)
//        } else {
//            // If the search text is empty, show all stocks (if required).
//            self.fetchAllStocks()
//        }
        
        // Check if the search text is empty
                if searchText.isEmpty {
                    // If the search text is empty, show all stocks
                    self.stocks = [] // Set this to your full array of stocks or fetch all stocks from the API again if needed.
                    self.collectionView.reloadData()
                } else {
                    // Perform the search operation with the entered text
                    let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    if let text = text {
                        self.fetchStocks(stockName: text)
                    }
                }
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
