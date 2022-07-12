//
//  MainCollectionViewCell.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 02.07.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MainCell"
    
    lazy var button: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "buttonCell")
        button.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var count: UILabel = {
        let count = makeLabel(font: .systemFont(ofSize: DynamicFontSize().dynamicFontSize(25), weight: .heavy), textAlignment: .center)
        return count
    }()
    
    lazy var lastDayCount: UILabel = {
        let count = makeLabel(font: .systemFont(ofSize: DynamicFontSize().dynamicFontSize(15), weight: .regular), textAlignment: .left)
        count.minimumScaleFactor = 0.5
        count.adjustsFontSizeToFitWidth = true
        return count
    }()
    
    lazy var title: UILabel = {
        let title = makeLabel(font: UIFont.systemFont(ofSize: DynamicFontSize().dynamicFontSize(18)), textAlignment: .center)
        title.numberOfLines = 0
        return title
    }()
    
    private func makeLabel(font: UIFont, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = textAlignment
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        contentView.addSubview(image)
        contentView.addSubview(count)
        contentView.addSubview(lastDayCount)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            count.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            count.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor),
            count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (contentView.frame.width)/5),
            
            lastDayCount.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15),
            lastDayCount.leadingAnchor.constraint(equalTo: count.trailingAnchor, constant: 0),
            lastDayCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            title.topAnchor.constraint(equalTo: count.bottomAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            title.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
