//
//  ButtonsView.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 22.07.2023.
//

import UIKit

extension ButtonsView {
    enum State {
        case active
        case inactive
    }
}

class ButtonsView: UIView {
    
    var state = State.active {
        didSet {
            animateStateSetting()
        }
    }
    
    let stocksButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stoks", for: .normal)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 28)
        button.addTarget(self, action: #selector(stocksButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        button.alpha = 1
        return button
    }()
    
    let favsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Favourite", for: .normal)
        button.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 18)
        button.addTarget(self, action: #selector(favsButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        button.alpha = 0.3
        return button
    }()
    
    let stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .bottom
        stack.distribution = .fillEqually
        return stack
    }()
    
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
            stackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackButton.heightAnchor.constraint(equalToConstant: 32),
            stackButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func configureAppearance() {}
}

//MARK: - Настройка кнопок
extension ButtonsView {
    @objc public func stocksButtonTapped() {
        if state == .inactive {
            state = .active
            print("Кнопка стокс нажата")
        }
    }

    @objc public func favsButtonTapped() {
        if state == .active {
            state = .inactive
            print("Кнопка любимое нажата")
        }
    }
    
    func animateStateSetting() {
        switch state {
        case .active:
            stocksButton.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 28)
            stocksButton.alpha = 1
        case .inactive:
            stocksButton.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 18)
            stocksButton.alpha = 0.3
        }
        switch state {
        case .active:
            favsButton.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 18)
            favsButton.alpha = 0.3
        case .inactive:
            favsButton.titleLabel?.font = Resourses.Fonts.helveticaRegular(with: 28)
            favsButton.alpha = 1
        }
        
    }
}

