//
//  CompanyCell.swift
//  InvestmentApp_Yandex
//
//  Created by Arina on 16.07.2023.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    static let reuseID = "CollectionCell"
    
    // TODO: проверить тип лого, который будет приходить с сервера UIImageView??
    private let logo: UIImageView = {
        let logo = UIImageView()
        logo.layer.cornerRadius = 15
        logo.backgroundColor = .black
        logo.tintColor = .blue
        return logo
    }()
    
    private let star: UIImageView = {
        let view = UIImageView()
        view.image = Resourses.Images.star
        return view
    }()
    
    private let companyStarStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0 //3
        return view
    }()
    
    private let companyNameStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 0 //3
        return view
    }()
    
    private let title: UILabel = {
        let lable = UILabel()
//        lable.font = Resourses.Fonts.montserrat(withSize: 18) // при указании размера падает
        lable.textColor = .black
        return lable
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
//        label.font = Resourses.Fonts.montserrat(withSize: 12) // при указании размера падает
        label.textColor = .gray
        return label
    }()
    
    private let companyPriceStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        view.alignment = .trailing
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100000"
//        label.font = Resourses.Fonts.montserrat(withSize: 18) // при указании размера падает
        label.tintColor = .black
        return label
    }()
    
    private let pricePercentLabel: UILabel = {
        let label = UILabel()
        label.text = "5%"
//        label.font = Resourses.Fonts.montserrat(withSize: 12) // при указании размера падает
        label.tintColor = .green
        return label
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
    
    func configure(withTitle: String, subtitle: String, isFavourite: Bool) {
        self.title.text = withTitle.uppercased()
        self.subtitle.text = subtitle
        
        star.image = isFavourite ? Resourses.Images.starFav : Resourses.Images.star
    }
}

private extension CollectionCell {
    func setupViews() {
        addSubview(logo)
        addSubview(companyStarStackView)
        companyStarStackView.addArrangedSubview(star)
        companyStarStackView.addArrangedSubview(title) // ПАДАЕТ
        addSubview(companyNameStackView)
        companyNameStackView.addArrangedSubview(companyStarStackView)
        companyNameStackView.addArrangedSubview(subtitle) // ПАДАЕТ
        addSubview(companyPriceStackView)
        companyPriceStackView.addArrangedSubview(priceLabel) // ПАДАЕТ
        companyPriceStackView.addArrangedSubview(pricePercentLabel) // ПАДАЕТ
    }
    
    func constraintViews() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        companyStarStackView.translatesAutoresizingMaskIntoConstraints = false
        companyNameStackView.translatesAutoresizingMaskIntoConstraints = false
        companyPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 52),
            logo.widthAnchor.constraint(equalTo: logo.heightAnchor),

            companyNameStackView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8),
            companyNameStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyNameStackView.trailingAnchor.constraint(equalTo: companyPriceStackView.leadingAnchor, constant: -15),

            companyPriceStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyPriceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//            companyPriceStackView.heightAnchor.constraint(equalToConstant: 25),
//            companyPriceStackView.widthAnchor.constraint(equalToConstant: 25),
//            companyPriceStackView.leadingAnchor.constraint(equalTo: companyNameStackView.trailingAnchor)
        ])
        
    }
    
    func configureAppearance() {
        backgroundColor = .red
        layer.borderWidth = 1
//        layer.borderColor = UIColor(named: "maingrey")?.cgColor
    }
}

