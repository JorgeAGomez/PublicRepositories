//
//  UIImage+Helper.swift
//
//  Created by Jorge Gomez on 2018-01-28
//  Copyright © 2017 Vog App Developers. All rights reserved.
//  From Brian --> 'Lets build that app' Youtube Channel.

/*

    

*/

import Foundation
import UIKit

extension UIImage {
    public static func getWindowImage() -> UIImage? {
        if let keyWindow = UIApplication.shared.keyWindow {
            UIGraphicsBeginImageContextWithOptions(keyWindow.frame.size, keyWindow.isOpaque, 0)
            keyWindow.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
