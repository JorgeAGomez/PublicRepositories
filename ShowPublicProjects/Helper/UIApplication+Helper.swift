//
//  UIApplication+TopController.swift
//  Arc
//
//  Created by Jorge Gomez on 2018-02-11.
//  Copyright © 2018 ARC. All rights reserved.
//

import Foundation
import UIKit

//  get the view controller from other classes such as UITableViewCells.
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
