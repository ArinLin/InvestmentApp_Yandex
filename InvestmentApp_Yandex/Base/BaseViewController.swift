//
//  BaseViewController.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 15.07.2023.
//

import UIKit

class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        layoutViews()
        configure()
    }
}

@objc extension BaseController {
    func addViews() {}
    func layoutViews() {}
    func configure() {
        view.backgroundColor = .white
    }
    // нужно определить 2 функции из настройки кнопок
    func navBarStocksButtonHandler() {
        print("Stocks button tapped")
    }
    
    func navBarFavouriteButtonHandler() {
        print("Favourite button tapped")
    }
}
// для того, чтобы выбирать какая кнопка будет левая или правая?
enum NavBarPosition {
    case stocks
    case favs
}

// для добавления кнопок в контроллеры, создаем в BaseController расширение
extension BaseController {
    func addNavigationBarButton(at position: NavBarPosition, title: String) {
        // создаем кнопку
        let button = UIButton(type: .system)
        // устанавливаем тайтл
        button.setTitle(title, for: .normal)
        // устанавливаем цвет
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.gray, for: .disabled)
        // устанавливаем шрифт
        button.titleLabel?.font = Resourses.Fonts.montserrat(withSize: 18)
        
        // смотря как позиция кнопки, нужно добавить таргет
        switch position {
        case .stocks:
            button.addTarget(self, action: #selector(navBarStocksButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .favs:
            button.addTarget(self, action: #selector(navBarFavouriteButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
//    func setTitleForNavBarButton(buttonTitle: String, at position: NavBarPosition) {
//        switch position {
//        case .stocks:
//            (navigationItem.leftBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
//        case .favs:
//            (navigationItem.rightBarButtonItem?.customView as? UIButton)?.setTitle(title, for: .normal)
//        }
//        view.layoutIfNeeded() // чтобы хватало место кнопке и не появлялось троеточие
//    }
}


