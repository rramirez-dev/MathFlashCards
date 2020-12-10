//
//  MathProblem.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 7/27/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class MathProblemViewController: UIView {
  var baseFactorLabel = UILabel()
  var factorLabel = UILabel()
  var operationImageView = UIImageView()
  private var barLabel = UILabel()
  private var factorsVStack = UIStackView()
  private var operationHStack = UIStackView()
  private var factorFont = UIFont(name: "ArialRoundedMTBold", size: UIScreen.main.bounds.width * 0.50)//%0.6133333333333333
  private var barView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureBarView()
    configureFactorsVStack()
    configureFactorLabel()
    configureBaseFactorLabel()
    configureOperationImageView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureBarView() {
    barView.backgroundColor = .white
    barView.layer.cornerRadius = 10
    addSubview(barView)
    setBarViewConstraints()
  }

  private func setBarViewConstraints() {
    barView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      barView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      barView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      barView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      barView.heightAnchor.constraint(equalToConstant: 20)
    ])
  }

  private func configureFactorsVStack() {
    factorsVStack.alignment = .bottom
    factorsVStack.axis = .vertical
    factorsVStack.distribution = .fillProportionally
    addSubview(factorsVStack)
    setFactorVStackConstraints()
  }

  private func setFactorVStackConstraints() {
    factorsVStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      factorsVStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      factorsVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
      factorsVStack.bottomAnchor.constraint(equalTo: barView.topAnchor, constant: 0)
    ])
  }

  private func configureOperationImageView() {
    operationImageView = UIImageView()
    //operationImageView.backgroundColor = .red
    addSubview(operationImageView)
    setOperationImageViewConstraints()
  }

  private func setOperationImageViewConstraints() {
    operationImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      operationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      operationImageView.trailingAnchor.constraint(equalTo: factorsVStack.leadingAnchor, constant: -10),
      operationImageView.bottomAnchor.constraint(equalTo: barView.topAnchor, constant: -35),
      operationImageView.heightAnchor.constraint(equalTo: operationImageView.widthAnchor)
    ])
  }

  private func configureFactorLabel() {
    factorLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
    //factorLabel.backgroundColor = .blue
    factorLabel.font = factorFont
    factorLabel.textAlignment = .right
    factorLabel.textColor = .white
    factorsVStack.addArrangedSubview(factorLabel)
  }

  private func configureBaseFactorLabel() {
    baseFactorLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
    //baseFactorLabel.backgroundColor = .green
    baseFactorLabel.font = factorFont
    baseFactorLabel.textAlignment = .right
    baseFactorLabel.textColor = .white
    factorsVStack.addArrangedSubview(baseFactorLabel)
  }
}
