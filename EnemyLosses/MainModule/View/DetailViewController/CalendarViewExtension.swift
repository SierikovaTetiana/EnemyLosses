//
//  File.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 08.07.2022.
//

import UIKit

extension CalendarView {
    
    func makeEquipmentImage() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }
    
    func makeBackView() -> UIStackView {
        let backView = UIStackView(arrangedSubviews: [monthBack, monthLabel, monthNext])
        backView.clipsToBounds = true
        backView.distribution = .fillEqually
        backView.axis = .horizontal
        backView.addArrangedSubview(monthBack)
        backView.addArrangedSubview(monthLabel)
        backView.addArrangedSubview(monthNext)
        backView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backView)
        return backView
    }
    
    func makeMonthLabel() -> UILabel {
        let label = makeLabel(font: .systemFont(ofSize: DynamicFontSize().dynamicFontSize(25), weight: .heavy))
        return label
    }
    
    func makeMonthBack() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }
    
    func makeMonthNext() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        return collectionView
    }
    
    func makeCollectionFlowLayout() -> UICollectionViewFlowLayout {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        let width = (self.frame.width - 20) / 8
        let height = (self.frame.height) / 8
        collectionFlowLayout.itemSize = CGSize(width: width, height: height)
        return collectionFlowLayout
    }
    
    func makeMonthLossesCountLabel() -> UILabel {
        let label = makeLabel(font: .systemFont(ofSize: DynamicFontSize().dynamicFontSize(25), weight: .heavy))
        return label
    }
    
    func makeMonthLossesLabel() -> UILabel {
        let label = makeLabel(font: .systemFont(ofSize: DynamicFontSize().dynamicFontSize(25), weight: .regular))
        return label
    }
    
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        return activityIndicator
    }
    
    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        return label
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            equipmentImage.topAnchor.constraint(equalTo: topAnchor),
            equipmentImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            equipmentImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            equipmentImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            monthLossesCountLabel.topAnchor.constraint(equalTo: equipmentImage.bottomAnchor, constant: 10),
            monthLossesCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            monthLossesCountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            monthLossesLabel.topAnchor.constraint(equalTo: equipmentImage.bottomAnchor, constant: 10),
            monthLossesLabel.leadingAnchor.constraint(equalTo: monthLossesCountLabel.trailingAnchor),
            monthLossesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            backView.topAnchor.constraint(equalTo: monthLossesLabel.bottomAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: backView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 5),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        collectionView.collectionViewLayout = collectionFlowLayout
    }
}
