//
//  UILabel+Helper.swift
//  Arc
//
//  Created by Jorge Gomez on 2018-02-11.
//  Copyright © 2018 ARC. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
