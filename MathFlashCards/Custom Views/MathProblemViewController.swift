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
  private var operationHStack = UIStackView()
  private var factorFont = UIFont(name: "ArialRoundedMTBold", size: UIScreen.main.bounds.width * 0.50)
  private var barView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureBarView()
    configureOperationImageView()
    configureBaseFactorLabel()
    configureFactorLabel()
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

  private func configureOperationImageView() {
    operationImageView = UIImageView()
    addSubview(operationImageView)
    setOperationImageViewConstraints()
  }

  private func setOperationImageViewConstraints() {
    operationImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      operationImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      operationImageView.bottomAnchor.constraint(equalTo: barView.topAnchor, constant: -30),
      operationImageView.heightAnchor.constraint(equalTo: operationImageView.widthAnchor)
    ])
  }

  private func configureFactorLabel() {
    factorLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .vertical)
    factorLabel.font = factorFont
    factorLabel.textAlignment = .right
    factorLabel.textColor = .white
    addSubview(factorLabel)
    setFactorLabelConstraints()
  }

  private func setFactorLabelConstraints() {
    factorLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      factorLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10),
      factorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10),
      factorLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -10),
      factorLabel.bottomAnchor.constraint(equalTo: baseFactorLabel.topAnchor, constant: 0)
    ])
  }

  private func configureBaseFactorLabel() {
    baseFactorLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
    baseFactorLabel.font = factorFont
    baseFactorLabel.textAlignment = .right
    baseFactorLabel.textColor = .white
    addSubview(baseFactorLabel)
    setBaseFactorLabelConstraints()
  }

  private func setBaseFactorLabelConstraints() {
    baseFactorLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      baseFactorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: operationImageView.trailingAnchor, constant: -5),
      baseFactorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      baseFactorLabel.bottomAnchor.constraint(equalTo: barView.topAnchor, constant: 0)
    ])
  }
}
