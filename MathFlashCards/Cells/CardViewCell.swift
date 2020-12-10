//
//  CardViewCell.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 5/4/19.
//  Copyright © 2019 Robert Ramirez. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
  static let reuseIdentifier = "cardViewCell"
  var cellIndexLabel = UILabel()
  var baseFactorLabel = UILabel()
  var factorLabel = UILabel()
  var operationImageView = UIImageView()
  var answerLabel = UILabel()
  var frontCard = UIView()
  var backCard = UIView()
  var mathProblem = MathProblemViewController()
  var cardCounterLbl = UILabel()
  weak var delegate: UpdateCardGuessDelegate?
  private lazy var checkmarkCircle = UIImage(systemName: "checkmark.circle", withConfiguration: symbolConfig)
  private lazy var checkmarkCircleFilled = UIImage(systemName: "checkmark.circle.fill", withConfiguration: symbolConfig)
  private lazy var xCircle = UIImage(systemName: "x.circle", withConfiguration: symbolConfig)
  private lazy var xCircleFilled = UIImage(systemName: "x.circle.fill", withConfiguration: symbolConfig)
  private var barLabel = UILabel()
  private var factorsVStack = UIStackView()
  private var operationHStack = UIStackView()
  private var factorFont = UIFont(name: "ArialRoundedMTBold", size: UIScreen.main.bounds.width * 0.50)
  private var barView = UIView()
  private var xCheckmarkHStack = UIStackView()
  private var correctBtn = UIButton()
  private var incorrectBtn = UIButton()
  private let symbolConfig = UIImage.SymbolConfiguration(pointSize: 90.0, weight: .light)

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureCardCounterLabel()
    configureBackCard()
    configureFrontCard()
    configureMathProblem()
    configureAnswerLabel()
    configureXCheckmarkHStack()
    configureCorrectBtn()
    configureIncorrectBtn()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func setCard(_ card: Card) {
    backCard.isHidden = true
    frontCard.isHidden = false

    if let youGuessedCorrectly = card.youGuessedCorrectly {
      if youGuessedCorrectly {
        correctBtn.setImage(checkmarkCircleFilled, for: .normal)
        incorrectBtn.setImage(xCircle, for: .normal)
      } else {
        correctBtn.setImage(checkmarkCircle, for: .normal)
        incorrectBtn.setImage(xCircleFilled, for: .normal)
      }
    } else {
      correctBtn.setImage(checkmarkCircle, for: .normal)
      incorrectBtn.setImage(xCircle, for: .normal)
    }
  }

  func enableTestMode(enabled: Bool) {
    incorrectBtn.isHidden = !enabled
    correctBtn.isHidden = !enabled
  }

  private func configureCardCounterLabel() {
    //cardCounterLbl.backgroundColor = .blue
    cardCounterLbl.font = deckFont?.withSize(UIScreen.main.bounds.width * 0.10)//20
    cardCounterLbl.textColor = .white
    frontCard.addSubview(cardCounterLbl)
    setCardCounterLabelConstraints()
  }

  private func setCardCounterLabelConstraints() {
    cardCounterLbl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      cardCounterLbl.centerXAnchor.constraint(equalTo: frontCard.centerXAnchor, constant: 0)
    ])
  }

  private func configureAnswerLabel() {
    answerLabel.textColor = .white
    answerLabel.textAlignment = .center
    answerLabel.adjustsFontSizeToFitWidth = true
    answerLabel.minimumScaleFactor = 0.5
    answerLabel.font = factorFont
    backCard.addSubview(answerLabel)
    setAnswerLabelConstraints()
  }

  private func setAnswerLabelConstraints() {
    answerLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      answerLabel.leadingAnchor.constraint(equalTo: backCard.leadingAnchor, constant: 10),
      answerLabel.trailingAnchor.constraint(equalTo: backCard.trailingAnchor, constant: -10),
      answerLabel.centerYAnchor.constraint(equalTo: backCard.centerYAnchor)
    ])
  }

  private func configureMathProblem() {
    //mathProblem.backgroundColor = .black
    mathProblem.backgroundColor = .clear
    mathProblem.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
    frontCard.addSubview(mathProblem)
    setMathProblemConstraints()
    setMathProblemConstraints()
  }

  private func setMathProblemConstraints() {
    mathProblem.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      mathProblem.leadingAnchor.constraint(equalTo: frontCard.leadingAnchor, constant: 10),
      mathProblem.trailingAnchor.constraint(equalTo: frontCard.trailingAnchor, constant: -10),
      mathProblem.bottomAnchor.constraint(equalTo: cardCounterLbl.topAnchor, constant: -15),
      mathProblem.centerXAnchor.constraint(equalTo: frontCard.centerXAnchor, constant: 0),
      mathProblem.centerYAnchor.constraint(equalTo: frontCard.centerYAnchor, constant: 0)
    ])
  }

  private func configureFrontCard() {
    let tapFrontCard = UITapGestureRecognizer(target: self, action: #selector(flipFrontCard))
    frontCard.addGestureRecognizer(tapFrontCard)
    //frontCard.backgroundColor = .red
    frontCard.backgroundColor = UIColor.darkModeBackgroundColor
    contentView.addSubview(frontCard)
    setFrontCardConstraints()
  }

  private func setFrontCardConstraints() {
    frontCard.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      frontCard.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
      frontCard.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      frontCard.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      frontCard.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    ])
  }

  private func configureBackCard() {
    let tapBackCard = UITapGestureRecognizer(target: self, action: #selector(flipBackCard))

    backCard.addGestureRecognizer(tapBackCard)
    backCard.backgroundColor = UIColor.darkModeBackgroundColor
    backCard.isHidden = false
    contentView.addSubview(backCard)
    setBackCardConstraints()
  }

  private func setBackCardConstraints() {
    backCard.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      backCard.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
      backCard.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      backCard.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      backCard.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    ])
  }

  private func configureXCheckmarkHStack() {
    xCheckmarkHStack.alignment = .center
    xCheckmarkHStack.axis = .horizontal
    xCheckmarkHStack.distribution = .equalSpacing
    xCheckmarkHStack.spacing = 20
    backCard.addSubview(xCheckmarkHStack)
    setXCheckmarkHStackConstraints()
  }

  private func setXCheckmarkHStackConstraints() {
    xCheckmarkHStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      xCheckmarkHStack.bottomAnchor.constraint(equalTo: backCard.bottomAnchor, constant: -20),
      xCheckmarkHStack.leadingAnchor.constraint(equalTo: backCard.leadingAnchor, constant: 10),
      xCheckmarkHStack.trailingAnchor.constraint(equalTo: backCard.trailingAnchor, constant: -10)
    ])
  }

  private func configureCorrectBtn() {
    correctBtn.tag = 1
    correctBtn.setImage(checkmarkCircle, for: [.normal])
    correctBtn.tintColor = .white
    correctBtn.addTarget(self, action: #selector(guess(sender:)), for: .touchUpInside)
    xCheckmarkHStack.addArrangedSubview(correctBtn)
  }

  private func configureIncorrectBtn() {
    incorrectBtn.tag = 2
    incorrectBtn.setImage(xCircle, for: .normal)
    incorrectBtn.tintColor = .white
    incorrectBtn.addTarget(self, action: #selector(guess(sender:)), for: .touchUpInside)
    xCheckmarkHStack.addArrangedSubview(incorrectBtn)
  }

  private func flip() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]

    UIView.transition(from: frontCard, to: backCard, duration: 0.5, options: transitionOptions, completion: nil)
  }

  private func flipBack() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]

    UIView.transition(from: backCard, to: frontCard, duration: 0.5, options: transitionOptions, completion: nil)
  }

  // MARK: Action Methods
  @objc private func flipFrontCard() {
    flip()
  }

  @objc private func flipBackCard() {
    flipBack()
  }

  @objc private func guess(sender: UIButton) {
    guard let cellIndexText = cellIndexLabel.text else { return }
    guard let cellIndex = Int(cellIndexText) else { return }

      if sender.tag == 1 {
        if sender.isSelected || sender.isHighlighted {
          incorrectBtn.setImage(xCircle, for: .normal)
          correctBtn.setImage(checkmarkCircleFilled, for: [.normal])
          delegate?.setYouGuessedCorrectly(guessWasCorrect: true, indexPath: IndexPath(row: cellIndex, section: 0))
        }
      } else {
        if sender.isSelected || sender.isHighlighted {
          correctBtn.setImage(checkmarkCircle, for: .normal)
          incorrectBtn.setImage(xCircleFilled, for: [.normal])
          delegate?.setYouGuessedCorrectly(guessWasCorrect: false, indexPath: IndexPath(row: cellIndex, section: 0))
        }
      }
  }
}
