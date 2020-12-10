//
//  Operation.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 5/13/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import Foundation
import UIKit

enum Operation: String {
  case addition = "+"
  case subtraction = "-"
  case multiplication = "x"
  case division = "÷"

  static func getOperationSign(operation: String) -> String {
    switch operation {
    case Operation.addition.rawValue:
      return Operation.addition.rawValue
    case Operation.subtraction.rawValue:
      return Operation.subtraction.rawValue
    case Operation.multiplication.rawValue:
      return Operation.multiplication.rawValue
    case Operation.division.rawValue:
      return Operation.division.rawValue
    default:
      return ""
    }
  }

  static func getOperationSFSymbol(operation: String) -> String {
    switch operation {
    case Operation.addition.rawValue:
      return OperationSFSymbol.additon.rawValue
    case Operation.subtraction.rawValue:
      return OperationSFSymbol.subtraction.rawValue
    case Operation.multiplication.rawValue:
      return OperationSFSymbol.multiplication.rawValue
    case Operation.division.rawValue:
      return OperationSFSymbol.division.rawValue
    default:
      return ""
    }
  }

  static func getOperationDescription(tag: Int) -> String {
    switch tag {
    case 1:
      return "Addition"
    case 2:
      return "Multiplication"
    case 3:
      return "Division"
    case 4:
      return "Subtraction"
    default:
      return ""
    }
  }
}

enum OperationSFSymbol: String {
  case additon = "plus"
  case subtraction = "minus"
  case multiplication = "multiply"
  case division = "divide"
}
