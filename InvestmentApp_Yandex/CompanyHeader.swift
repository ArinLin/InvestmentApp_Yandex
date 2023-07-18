//
//  CompanyHeader.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 17.07.2023.
//

import UIKit

extension CompanyHeader {
    enum State {
        case stocksIsActiv
        case favsIsActiv
    }
}

open class CompanyHeader: UICollectionReusableView {
    static let reuseID = "CompanyHeader"
    
    let stocksButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 28)
        button.tintColor = .black
        button.alpha = 1
        return button
    }()
    
    let favsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 18)
        button.tintColor = .black
        button.alpha = 0.3
        return button
    }()
    
    var state = State.stocksIsActiv {
        didSet {
            animateStateSetting()
        }
    }
    
    private let animatiomTimeInterval: TimeInterval = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required public init?(coder: NSCoder) {
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

//MARK: - Настройка кнопок
extension CompanyHeader {
    @IBAction public func stocksButtonTapped() {
        if state == .favsIsActiv {
            state = .stocksIsActiv
            print("Кнопка стокс нажата")
        }
    }

    @IBAction public func favsButtonTapped() {
        if state == .stocksIsActiv {
            state = .favsIsActiv
            print("Кнопка любимое нажата")
        }
    }
    
    func animateStateSetting() {
        let activeButton = state == .stocksIsActiv ? favsButton : stocksButton
        let inactiveButton = state == .favsIsActiv ? stocksButton : favsButton
        
        UIView.animate(withDuration: animatiomTimeInterval / 2) {
            activeButton.alpha = 0.3
            inactiveButton.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: self.animatiomTimeInterval / 2) {
                activeButton.tintColor = .black
                inactiveButton.alpha = 0.3
//                activeButton.transform = CGAffineTransform(translationX: 100, y: .zero)
//                inactiveButton.transform = CGAffineTransform(translationX: -100, y: .zero)
            }
        }
    }
}
