//
//  OperationButton.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 3/28/22.
//  Copyright © 2022 Robert Ramirez. All rights reserved.
//

import UIKit

class OperationButton: UIButton {
  let btnCornerRadius: CGFloat = 15.0
  let btnBorderWidth: CGFloat = 2.0
  let borderColor = UIColor.white

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.titleLabel?.font = operationFont
    self.layer.cornerRadius = btnCornerRadius
    self.layer.borderWidth = btnBorderWidth
    self.layer.borderColor = borderColor.cgColor
    self.tintColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
