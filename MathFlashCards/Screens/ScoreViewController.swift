//
//  ScoreVC.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 7/16/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
  var correctCountLbl = UILabel()
  var incorrectCountLbl = UILabel()
  var unasweredCountLbl = UILabel()
  var scoreMessageLbl = UILabel()
  var scoreLbl = UILabel()
  private var correctAnswerLblVStack = UIStackView()
  private var incorrectAnswerLblVStack = UIStackView()
  private var unansweredLblVStack = UIStackView()
  private var correctAnswerLbl = UILabel()
  private var incorrectAnswerLbl = UILabel()
  private var skippedLbl = UILabel()
  private var answerSummaryHStack = UIStackView()
  private var startOverBtn = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    configureView()
    configureNavigation()
    configureScoreLabel()
    configureStartOverBtn()

    configureAnswerSummaryHStack()
    configureCorrectAnswerLblVStack()
    configureIncorrectAnswerLblVStack()
    configureUnanswerLblVStack()

    configureCorrectAnswerLbl()
    configureCorrectCountLbl()

    configureIncorrectAnswerLbl()
    configureIncorrectCountLbl()

    configureUnansweredLbl()
    configureUnansweredCountLbl()
    configureScoreMessageLbl()
  }

  private func configureView() {
    view.backgroundColor = UIColor.darkModeBackgroundColor
  }

  private func configureNavigation() {
    navigationItem.setHidesBackButton(true, animated: false)
  }

  private func configureScoreMessageLbl() {
    scoreMessageLbl.textAlignment = .center
    scoreMessageLbl.numberOfLines = 1
    scoreMessageLbl.minimumScaleFactor = 0.5
    scoreMessageLbl.adjustsFontSizeToFitWidth = true
    scoreMessageLbl.font = deckFont
    scoreMessageLbl.textColor = .white
    view.addSubview(scoreMessageLbl)
    setScoreMessageLblConstraints()
  }

  private func setScoreMessageLblConstraints() {
    scoreMessageLbl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      scoreMessageLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      scoreMessageLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      scoreMessageLbl.bottomAnchor.constraint(equalTo: scoreLbl.topAnchor, constant: -20)
    ])
  }

  private func configureStartOverBtn() {
    startOverBtn.setTitle("Start Over", for: .normal)
    startOverBtn.titleLabel?.font = deckFont
    startOverBtn.layer.borderColor = UIColor.white.cgColor
    startOverBtn.layer.cornerRadius = 15
    startOverBtn.layer.borderWidth = 2
    startOverBtn.addTarget(self, action: #selector(startOver), for: .touchUpInside)
    view.addSubview(startOverBtn)
    setStartOverBtnConstraints()
  }

  private func setStartOverBtnConstraints() {
    startOverBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      startOverBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      startOverBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      startOverBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      startOverBtn.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  private func configureScoreLabel() {
    scoreLbl.font = deckFont?.withSize(100)
    scoreLbl.textColor = .white
    view.addSubview(scoreLbl)
    setScoreLabelConstraints()
  }

  private func setScoreLabelConstraints() {
    scoreLbl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      scoreLbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10),
      scoreLbl.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 10)
    ])
  }

  private func configureAnswerSummaryHStack() {
    answerSummaryHStack.alignment = .center
    answerSummaryHStack.axis = .horizontal
    answerSummaryHStack.distribution = .equalSpacing
    answerSummaryHStack.spacing = 20
    view.addSubview(answerSummaryHStack)
    setAnswerSummaryHStackContraints()
  }

  private func setAnswerSummaryHStackContraints() {
    answerSummaryHStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      answerSummaryHStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      answerSummaryHStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      answerSummaryHStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
    ])
  }

  private func configureCorrectAnswerLbl() {
    correctAnswerLbl.text = "Correct"
    correctAnswerLbl.font = deckFont?.withSize(20)
    correctAnswerLbl.textColor = .white
    correctAnswerLblVStack.addArrangedSubview(correctAnswerLbl)
  }

  private func configureCorrectCountLbl() {
    correctCountLbl.textColor = .white
    correctCountLbl.font = deckFont?.withSize(20)
    correctAnswerLblVStack.addArrangedSubview(correctCountLbl)
  }

  private func configureIncorrectAnswerLbl() {
    incorrectAnswerLbl.text = "Incorrect"
    incorrectAnswerLbl.font = deckFont?.withSize(20)
    incorrectAnswerLbl.textColor = .white
    incorrectAnswerLblVStack.addArrangedSubview(incorrectAnswerLbl)
  }

  private func configureIncorrectCountLbl() {
    incorrectCountLbl.textColor = .white
    incorrectCountLbl.font = deckFont?.withSize(20)
    incorrectAnswerLblVStack.addArrangedSubview(incorrectCountLbl)
  }

  private func configureUnansweredLbl() {
    skippedLbl.text = "Skipped"
    skippedLbl.font = deckFont?.withSize(20)
    skippedLbl.textColor = .white
    unansweredLblVStack.addArrangedSubview(skippedLbl)
  }

  private func configureUnansweredCountLbl() {
    unasweredCountLbl.textColor = .white
    unasweredCountLbl.font = deckFont?.withSize(20)
    unansweredLblVStack.addArrangedSubview(unasweredCountLbl)
  }

  private func configureCorrectAnswerLblVStack() {
    correctAnswerLblVStack.alignment = .center
    correctAnswerLblVStack.axis = .vertical
    correctAnswerLblVStack.distribution = .fillProportionally
    answerSummaryHStack.addArrangedSubview(correctAnswerLblVStack)
  }

  private func configureIncorrectAnswerLblVStack() {
    incorrectAnswerLblVStack.alignment = .center
    incorrectAnswerLblVStack.axis = .vertical
    incorrectAnswerLblVStack.distribution = .fillProportionally
    answerSummaryHStack.addArrangedSubview(incorrectAnswerLblVStack)
  }

  private func configureUnanswerLblVStack() {
    unansweredLblVStack.alignment = .center
    unansweredLblVStack.axis = .vertical
    unansweredLblVStack.distribution = .fillProportionally
    answerSummaryHStack.addArrangedSubview(unansweredLblVStack)
  }

  // MARK: Action Methods
  @objc private func startOver() {
    let deckSelectorVC = CardDeckSelectorViewController()
    deckSelectorVC.modalTransitionStyle = .crossDissolve
    deckSelectorVC.modalPresentationStyle = .fullScreen
    navigationController?.popToRootViewController(animated: true)
  }
}
