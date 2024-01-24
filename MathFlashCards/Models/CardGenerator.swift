//
//  FlashCard.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 6/1/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import Foundation

public enum CardGenerator {
  static func generateCardDeck() -> [Operation: [Int: [Card]]] {
    var decks = [Operation: [Int: [Card]]]()
    let factorRange = Array(0...12)
    let operations = ["+", "-", "x", "÷"]

    for operation in operations {
      switch operation {
      case "+":
        decks[Operation.addition] = CardGenerator.generateMathProblems(operation: operation, factorRange: factorRange)
      case "-":
        decks[Operation.subtraction] = CardGenerator.generateMathProblems(operation: operation, factorRange: factorRange)
      case "x":
        decks[Operation.multiplication] = CardGenerator.generateMathProblems(operation: operation, factorRange: factorRange)
      case "÷":
        decks[Operation.division] = CardGenerator.generateMathProblems(operation: operation, factorRange: factorRange)
      default:
        fatalError("Unable to load cards into decks dictionary")
      }
    }

    return decks
  }

  static func generateMathProblems(operation: String, factorRange: [Int]) -> [Int: [Card]] {
    var expression = NSExpression()
    var cards = [Card]()
    var cardSets = [Int: [Card]]()
    var factor = 1
    var answer = 0
    // swiftlint:disable force_cast
    for baseFactor in factorRange {
      if operation == "-" {
        factor = baseFactor
        for _ in factorRange {
          expression = NSExpression(format: "\(factor) \(operation) \(baseFactor)")
          answer = expression.expressionValue(with: nil, context: nil) as! Int
          cards.append(Card(id: UUID().uuidString, baseFactor: String(baseFactor), factor: String(factor), operation: operation, answer: String(answer), isFlipped: false))
          factor += 1
        }
      } else if operation == "÷" {
        factor = baseFactor
        for _ in factorRange {
          expression = NSExpression(format: "\(factor) / \(baseFactor)")
          answer = expression.expressionValue(with: nil, context: nil) as! Int
          cards.append(Card(id: UUID().uuidString, baseFactor: String(baseFactor), factor: String(factor), operation: operation, answer: String(answer), isFlipped: false))
          baseFactor == 0 ? (factor += 1) : (factor += baseFactor)
        }
      } else {
        factor = 1
        for _ in factorRange {
          if operation == "x" {
            expression = NSExpression(format: "\(factor) * \(baseFactor)")
          } else {
            expression = NSExpression(format: "\(factor) \(operation) \(baseFactor)")
          }
          answer = expression.expressionValue(with: nil, context: nil) as! Int
          cards.append(Card(id: UUID().uuidString, baseFactor: String(baseFactor), factor: String(factor), operation: operation, answer: String(answer), isFlipped: false))
          factor += 1
        }
      }
      cardSets[baseFactor] = cards
      cards.removeAll()
    }
    return cardSets
  }
}
// swiftlint:enable force_cast
