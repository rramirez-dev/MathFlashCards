//
//  MathProblemViewController.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 1/11/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class CardCollectionViewController: UICollectionViewController {
  var testModeEnabled = false
  var cards = [Card]()
  // swiftlint:disable implicitly_unwrapped_optional
  private var card: Card!

  private let itemsPerRow: CGFloat = 1
  private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

  // swiftlint:enable implicitly_unwrapped_optional

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = UIColor.darkModeBackgroundColor
    collectionView.isPagingEnabled = true
    collectionView.delegate = self
    collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: CardViewCell.reuseIdentifier)
    configureBackBtn()
    configureDoneBarBtn()
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewCell.reuseIdentifier, for: indexPath) as? CardViewCell else {
      fatalError("Unable to dequeue CardViewCell")
    }

    card = cards[indexPath.row]
    cell.setCard(card)
    cell.mathProblem.factorLabel.text = card.factor
    cell.mathProblem.baseFactorLabel.text = card.baseFactor
    let operationSymbolImageConfig = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width * 0.20, weight: .heavy, scale: .large)
    let operationSymbolImage = UIImage(systemName: Operation.getOperationSFSymbol(operation: card.operation), withConfiguration: operationSymbolImageConfig)
    cell.mathProblem.operationImageView.tintColor = .white
    cell.mathProblem.operationImageView.image = operationSymbolImage
    cell.answerLabel.text = card.answer
    cell.delegate = self
    cell.enableTestMode(enabled: testModeEnabled)
    cell.cellIndexLabel.text = String(indexPath.row)
    cell.cardCounterLbl.text = "\(indexPath.row + 1) / \(cards.count)"

    return cell
  }

  private func configureBackBtn() {
    if testModeEnabled {
      navigationItem.setHidesBackButton(true, animated: false)
    }
  }

  private func configureDoneBarBtn() {
    if testModeEnabled {
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(calculateScore))
    }
  }

  private func setScoreMessageLbl(score: Double) -> String {
    switch score {
    case 100:
      return "Perfect"
    case 0...79:
      return "You need more practice"
    case 80...90:
      return "Good Job"
    case 91...99:
      return "Almost there"
    default:
      return ""
    }
  }

  // MARK: Action Methods

  @objc private func calculateScore() {
    let totalCardCount = cards.count
    let correctCount = (cards.filter { $0.youGuessedCorrectly == true }).count
    let incorrectCount = (cards.filter { $0.youGuessedCorrectly == false }).count
    let unansweredCount = (cards.filter { $0.youGuessedCorrectly == nil }).count
    let score = (Double(correctCount) / Double(totalCardCount)) * 100
    let formattedScore = "\(String(format: "%.0f", score))%"
    let scoreVC = ScoreViewController()
    scoreVC.scoreMessageLbl.text = setScoreMessageLbl(score: score)
    scoreVC.correctCountLbl.text = String(correctCount)
    scoreVC.incorrectCountLbl.text = String(incorrectCount)
    scoreVC.unasweredCountLbl.text = String(unansweredCount)
    scoreVC.scoreLbl.text = formattedScore
    scoreVC.modalTransitionStyle = .crossDissolve
    scoreVC.modalPresentationStyle = .fullScreen
    navigationController?.pushViewController(scoreVC, animated: false)
  }
}

extension CardCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let guide = view.safeAreaLayoutGuide
    let safeAreaLayoutWidth = guide.layoutFrame.size.width
    let safeAreaLayoutHeight = guide.layoutFrame.size.height

    return CGSize(width: safeAreaLayoutWidth, height: safeAreaLayoutHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension CardCollectionViewController: UpdateCardGuessDelegate {
  func setYouGuessedCorrectly(guessWasCorrect: Bool, indexPath: IndexPath) {
    cards[indexPath.row].youGuessedCorrectly = guessWasCorrect
  }
}
