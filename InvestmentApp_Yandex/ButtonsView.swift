//
//  ButtonsView.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 22.07.2023.
//

import UIKit

extension ButtonsView {
    enum State {
        case stocksIsActiv
        case favsIsActiv
    }
}

class ButtonsView: UIView {
    let stocksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stoks", for: .normal)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 28)
        button.tintColor = .black
        button.alpha = 1
        return button
    }()
    
    let favsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Favourite", for: .normal)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 18)
        button.tintColor = .black
        button.alpha = 0.3
        return button
    }()
    
    let stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .bottom
        stack.distribution = .fillEqually
        return stack
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


private extension ButtonsView {
    func setupViews() {
        addSubview(stackButton)
        stackButton.addArrangedSubview(stocksButton)
        stackButton.addArrangedSubview(favsButton)
    }
    
    func constraintViews() {
        stackButton.translatesAutoresizingMaskIntoConstraints = false
//        stocksButton.translatesAutoresizingMaskIntoConstraints = false
//        favsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackButton.heightAnchor.constraint(equalToConstant: 32),
            stackButton.widthAnchor.constraint(equalToConstant: 207),
//            stocksButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
////            button1.centerXAnchor.constraint(equalTo: centerXAnchor),
//            stocksButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//            favsButton.leadingAnchor.constraint(equalTo: stocksButton.trailingAnchor, constant: 8),
//            favsButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configureAppearance() {}
}

//MARK: - Настройка кнопок
extension ButtonsView {
    @objc public func stocksButtonTapped() {
        if state == .favsIsActiv {
            state = .stocksIsActiv
            print("Кнопка стокс нажата")
        }
    }

    @objc public func favsButtonTapped() {
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

