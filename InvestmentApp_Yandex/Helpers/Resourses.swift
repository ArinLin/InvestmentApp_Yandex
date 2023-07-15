//
//  Resourses.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 15.07.2023.
//

import UIKit

enum Resourses {
    enum Fonts {
        static func montserrat(withSize: CGFloat) -> UIFont {
            UIFont(name: "Montserrat", size: withSize) ?? UIFont()
        }
    }
    
    enum Images {
            static var loupe = UIImage(named: "loupe")?.resized(to: CGSize(width: 24, height: 24))
            static var star = UIImage(named: "starGrey")?.resized(to: CGSize(width: 16, height: 18))
            static var starFav = UIImage(named: "starFav")?.resized(to: CGSize(width: 16, height: 18))
    }
}

//MARK: Меняем размер загруженных иконок через растровые изображения, используя метод UIGraphicsImageRenderer
extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { context in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        return resizedImage
    }
}

