//
//  MainViewExtension.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 01.07.2022.
//

import UIKit

extension MainView {
    
    func makeUkraineFlagImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "flag")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }
    
    func makeTotalEnemyPersonLossesLabel() -> UILabel {
        let totalEnemyPersonLosses = makeLabel(numberOfLines: 1, fontSize: 40, fontWeight: .heavy, textAlignment: .left)
        totalEnemyPersonLosses.adjustsFontSizeToFitWidth = true
        totalEnemyPersonLosses.minimumScaleFactor = 0.5
        return totalEnemyPersonLosses
    }
    
    func makeDayEnemyPersonLossesLabel() -> UILabel {
        let dayEnemyPersonLosses = makeLabel(numberOfLines: 1, fontSize: 15, fontWeight: .regular, textAlignment: .left)
        return dayEnemyPersonLosses
    }
    
    func makeEnemyPersonLossesLabel() -> UILabel {
        let enemyPersonLossesLabel = makeLabel(numberOfLines: 0, fontSize: 20, fontWeight: .regular, textAlignment: .natural)
        return enemyPersonLossesLabel
    }
    
    func makeLabel(numberOfLines: Int, fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.font = .systemFont(ofSize: DynamicFontSize().dynamicFontSize(fontSize), weight: fontWeight)
        addSubview(label)
        return label
    }
    
    func makeCollectView() -> UICollectionView {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        let itemPerLine = 3.0
        let spacing = 5.0
        let width = UIScreen.main.bounds.size.width - spacing * CGFloat(itemPerLine - 1) - 10
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: width/itemPerLine, height: width / itemPerLine * 1.5)
        collectionFlowLayout.minimumInteritemSpacing = spacing
        collectionFlowLayout.minimumLineSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        return collectionView
    }
    
    func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        return activityIndicator
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 5),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            ukraineFlag.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            ukraineFlag.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            ukraineFlag.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            ukraineFlag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            totalEnemyPersonLosses.topAnchor.constraint(equalTo: ukraineFlag.bottomAnchor, constant: 0),
            totalEnemyPersonLosses.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            totalEnemyPersonLosses.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            dayEnemyPersonLosses.topAnchor.constraint(equalTo: ukraineFlag.bottomAnchor, constant: 0),
            dayEnemyPersonLosses.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            dayEnemyPersonLosses.leadingAnchor.constraint(equalTo: totalEnemyPersonLosses.trailingAnchor, constant: 5),
            
            enemyPersonLosses.topAnchor.constraint(equalTo: ukraineFlag.bottomAnchor, constant: 0),
            enemyPersonLosses.leadingAnchor.constraint(equalTo: dayEnemyPersonLosses.trailingAnchor, constant: 15),
            enemyPersonLosses.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: enemyPersonLosses.bottomAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
