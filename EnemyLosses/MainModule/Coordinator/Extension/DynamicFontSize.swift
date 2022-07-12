//
//  DynamicFontSize.swift
//  EnemyLosses
//
//  Created by Tetiana Sierikova on 12.07.2022.
//

import UIKit

class DynamicFontSize {
    
    public func dynamicFontSize(_ FontSize: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let calculatedFontSize = screenWidth / 375 * FontSize
        return calculatedFontSize
    }
}
