//
//  CalendarCollectionViewCell.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 07.07.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CalendarCell"
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lossesLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)
        contentView.addSubview(lossesLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            lossesLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            lossesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lossesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lossesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
