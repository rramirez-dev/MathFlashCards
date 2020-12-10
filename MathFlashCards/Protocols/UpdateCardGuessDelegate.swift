//
//  ViewPresenterDelegate.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 6/6/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import Foundation

protocol UpdateCardGuessDelegate: class {
  func setYouGuessedCorrectly(guessWasCorrect: Bool, indexPath: IndexPath)
}
