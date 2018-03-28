//
//  UIViewController+Helper.swift
//  Arc
//
//  Created by Jorge Gomez on 2018-02-11.
//  Copyright © 2018 ARC. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
  
  
  //just call this function to dismiss keyboard when tapping the anywhere on the screen
  func hideKeyboardWhenTappedAround(){
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    
  }
  
  //hides keyboard
  @objc func dismissKeyboard(){
    view.endEditing(true)
  }
  
}
