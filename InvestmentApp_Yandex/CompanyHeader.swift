//
//  CompanyHeader.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 17.07.2023.
//

import UIKit

final class CompanyHeader: UICollectionReusableView {
    static let reuseID = "CompanyHeader"
    
    let stocksButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    let favsButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupViews()
        constraintViews()
        configureAppearance()
    }
}

private extension CompanyHeader {
    func setupViews() {
        addSubview(stocksButton)
        addSubview(favsButton)
    }
    
    func constraintViews() {
        stocksButton.translatesAutoresizingMaskIntoConstraints = false
        favsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stocksButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            button1.centerXAnchor.constraint(equalTo: centerXAnchor),
            stocksButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            favsButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 8),
            favsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configureAppearance() {}
}
extension CompanyHeader {
    @objc func stocksButtonTapped() {
       print("Кнопка стокс нажата")
    }
    
    @objc func favsButtonTapped() {
        print("Кнопка любимое нажата")
    }
}
