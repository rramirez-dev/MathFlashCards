//
//  UIColor+Extension.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 8/3/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

extension UIColor {
  static var darkModeBackgroundColor: UIColor {
    guard let darkModeBackgroundColor = UIColor(named: "bgColorDarkMode") else {
      return UIColor.systemBackground
    }
    return darkModeBackgroundColor
  }

  static var deckListTint: UIColor {
    guard let deckListTint = UIColor(named: "deckListTint") else {
      return UIColor.systemGray
    }
    return deckListTint
  }
}
