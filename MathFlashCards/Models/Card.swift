//
//  Card.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 4/15/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import Foundation

struct Card {
  let id: String
  let baseFactor: String
  let factor: String
  let operation: String
  let answer: String
  var isFlipped: Bool
  var youGuessedCorrectly: Bool?
}
