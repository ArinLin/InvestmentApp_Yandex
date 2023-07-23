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
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
    
    enum Colors {
        static var grayCell = UIColor(hexString: "#F0F4F7")
        static var background = UIColor(hexString: "#FFFFFF")
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

//MARK: Ext for hex color values
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
