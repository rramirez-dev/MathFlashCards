//
//  CardDeckSelectorVC.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 7/1/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class CardDeckSelectorViewController: UIViewController {
  var operationBtnSize = CGSize(width: 160, height: 160)
  private var cardDeckList = CardDeckListViewController()
  private var testModeSwitchLbl = UILabel()
  private var testModeSwitchLblHStack = UIStackView()
  private var titleLbl = UILabel()
  private var additionBtn = UIButton()
  private var multiplicationBtn = UIButton()
  private var divisionBtn = UIButton()
  private var subtractionBtn = UIButton()
  private var topOperationBtnsHStack = UIStackView()
  private var bottomOperationBtnsHStack = UIStackView()
  private var operationBtnsVStackGrid = UIStackView()
  private var testModeEnabled = false
  private var testModeSwitch = UISwitch()
  private let btnCornerRadius: CGFloat = 15.0
  private let btnBorderWidth: CGFloat = 2.0
  private let borderColor = UIColor.white
  private let operatonsVStackGridSpacing: CGFloat = 10
  private let operationsBtnsHStackSpacing: CGFloat = 10
  private let operationBtnImageConfig = UIImage.SymbolConfiguration(pointSize: 130.0, weight: .light, scale: .default)

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.darkModeBackgroundColor
    scaleOperationBtn()
    configureOperationBtnsVStackGrid()
    configureTopOperationBtnsHStack()
    configureBottomOperationBtnsHStack()
    configureAdditionBtn()
    configureMultiplicationBtn()
    configureDivisionBtn()
    configureSubtractionBtn()
    configureTitleLabel()
    configureTestModeSwitchHStack()
    configureTestModeSwitchLbl()
    configureTestModeSwitch()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.barTintColor = UIColor.darkModeBackgroundColor
  }

  // MARK: Configure Title Label
  private func configureTitleLabel() {
    titleLbl.textAlignment = .center
    titleLbl.text = "Math Flash Cards"
    titleLbl.textColor = .white
    titleLbl.minimumScaleFactor = 0.5
    titleLbl.adjustsFontSizeToFitWidth = true
    titleLbl.font = deckFont?.withSize(45)
    view.addSubview(titleLbl)
    setTitleLabelConstraints()
  }

  private func setTitleLabelConstraints() {
    titleLbl.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      titleLbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10)
    ])
  }

  // MARK: Operation Buttons Stack View
  private func configureOperationBtnsVStackGrid() {
    operationBtnsVStackGrid.alignment = .center
    operationBtnsVStackGrid.spacing = operatonsVStackGridSpacing
    operationBtnsVStackGrid.distribution = .fillEqually
    operationBtnsVStackGrid.axis = .vertical
    view.addSubview(operationBtnsVStackGrid)
    setOperationsBtnsVStackGridConstraints()
  }

  private func setOperationsBtnsVStackGridConstraints() {
    operationBtnsVStackGrid.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      operationBtnsVStackGrid.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
      operationBtnsVStackGrid.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
    ])
  }

  // MARK: Operation Buttons HStack
  private func configureBottomOperationBtnsHStack() {
    bottomOperationBtnsHStack.alignment = .center
    bottomOperationBtnsHStack.axis = .horizontal
    bottomOperationBtnsHStack.spacing = operationsBtnsHStackSpacing
    bottomOperationBtnsHStack.distribution = .fillEqually
    operationBtnsVStackGrid.addArrangedSubview(bottomOperationBtnsHStack)
  }

  private func configureTopOperationBtnsHStack() {
    topOperationBtnsHStack.alignment = .center
    topOperationBtnsHStack.axis = .horizontal
    topOperationBtnsHStack.spacing = operationsBtnsHStackSpacing
    topOperationBtnsHStack.distribution = .fillEqually
    operationBtnsVStackGrid.addArrangedSubview(topOperationBtnsHStack)
  }

  private func setTopOperationBtnsHStackContraints() {
    topOperationBtnsHStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      topOperationBtnsHStack.topAnchor.constraint(equalTo: operationBtnsVStackGrid.topAnchor, constant: 0),
      topOperationBtnsHStack.leadingAnchor.constraint(equalTo: operationBtnsVStackGrid.leadingAnchor, constant: 0),
      topOperationBtnsHStack.trailingAnchor.constraint(equalTo: operationBtnsVStackGrid.trailingAnchor, constant: 0),
      topOperationBtnsHStack.bottomAnchor.constraint(equalTo: operationBtnsVStackGrid.bottomAnchor, constant: 0)
    ])
  }

  // MARK: Configure Addition Button
  private func configureAdditionBtn() {
    additionBtn.accessibilityLabel = "Addition"
    additionBtn.tag = 1
    additionBtn.titleLabel?.font = operationFont
    additionBtn.layer.cornerRadius = btnCornerRadius
    additionBtn.layer.borderWidth = btnBorderWidth
    additionBtn.layer.borderColor = borderColor.cgColor
    let plusSymbolImage = UIImage(systemName: OperationSFSymbol.additon.rawValue, withConfiguration: operationBtnImageConfig)
    additionBtn.tintColor = .white
    additionBtn.setImage(plusSymbolImage, for: .normal)
    additionBtn.addTarget(self, action: #selector(selectOperationBtn), for: .touchUpInside)
    topOperationBtnsHStack.addArrangedSubview(additionBtn)
    setAdditionBtnContraints()
  }

  private func setAdditionBtnContraints() {
    additionBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      additionBtn.heightAnchor.constraint(equalToConstant: operationBtnSize.height),
      additionBtn.widthAnchor.constraint(equalToConstant: operationBtnSize.width)
    ])
  }

  // MARK: Configure Multiplication Button
  private func configureMultiplicationBtn() {
    multiplicationBtn.accessibilityLabel = "Multiplication"
    multiplicationBtn.tag = 2
    multiplicationBtn.titleLabel?.font = operationFont
    multiplicationBtn.layer.cornerRadius = btnCornerRadius
    multiplicationBtn.layer.borderWidth = btnBorderWidth
    multiplicationBtn.layer.borderColor = borderColor.cgColor
    let multiplicationSymbolImage = UIImage(systemName: OperationSFSymbol.multiplication.rawValue, withConfiguration: operationBtnImageConfig)
    multiplicationBtn.setImage(multiplicationSymbolImage, for: .normal)
    multiplicationBtn.tintColor = .white
    multiplicationBtn.addTarget(self, action: #selector(selectOperationBtn), for: .touchUpInside)
    topOperationBtnsHStack.addArrangedSubview(multiplicationBtn)
    setMultiplicationBtnContraints()
  }

  private func setMultiplicationBtnContraints() {
    multiplicationBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      multiplicationBtn.heightAnchor.constraint(equalToConstant: operationBtnSize.height),
      multiplicationBtn.widthAnchor.constraint(equalToConstant: operationBtnSize.width)
    ])
  }

  // MARK: Configure Division Button
  private func configureDivisionBtn() {
    divisionBtn.accessibilityLabel = "Division"
    divisionBtn.tag = 3
    divisionBtn.titleLabel?.font = operationFont
    divisionBtn.layer.cornerRadius = btnCornerRadius
    divisionBtn.layer.borderWidth = btnBorderWidth
    divisionBtn.layer.borderColor = borderColor.cgColor
    let divisionSymbolImage = UIImage(systemName: OperationSFSymbol.division.rawValue, withConfiguration: operationBtnImageConfig)
    divisionBtn.setImage(divisionSymbolImage, for: .normal)
    divisionBtn.tintColor = .white
    divisionBtn.addTarget(self, action: #selector(selectOperationBtn), for: .touchUpInside)
    bottomOperationBtnsHStack.addArrangedSubview(divisionBtn)
    setDivisionBtnContraints()
  }

  private func setDivisionBtnContraints() {
    divisionBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      divisionBtn.heightAnchor.constraint(equalToConstant: operationBtnSize.height),
      divisionBtn.widthAnchor.constraint(equalToConstant: operationBtnSize.width)
    ])
  }

  // MARK: Configure Subtraction Button
  private func configureSubtractionBtn() {
    subtractionBtn.tag = 4
    subtractionBtn.titleLabel?.font = operationFont
    subtractionBtn.layer.masksToBounds = true
    subtractionBtn.layer.cornerRadius = btnCornerRadius
    subtractionBtn.layer.borderWidth = btnBorderWidth
    subtractionBtn.layer.borderColor = borderColor.cgColor
    let subtractionSymbolImage = UIImage(systemName: OperationSFSymbol.subtraction.rawValue, withConfiguration: operationBtnImageConfig)
    subtractionBtn.setImage(subtractionSymbolImage, for: .normal)
    subtractionBtn.imageView?.contentMode = .scaleAspectFill
    subtractionBtn.tintColor = .white
    subtractionBtn.addTarget(self, action: #selector(selectOperationBtn), for: .touchUpInside)
    bottomOperationBtnsHStack.addArrangedSubview(subtractionBtn)
    setSubtractionBtnContraints()
  }

  private func setSubtractionBtnContraints() {
    subtractionBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      subtractionBtn.heightAnchor.constraint(equalToConstant: operationBtnSize.height),
      subtractionBtn.widthAnchor.constraint(equalToConstant: operationBtnSize.width)
    ])
  }

  private func configureTestModeSwitchLbl() {
    testModeSwitchLbl.font = UIFont.boldSystemFont(ofSize: 23)
    testModeSwitchLbl.textColor = .white
    testModeSwitchLbl.text = "Test Mode:"
    testModeSwitchLblHStack.addArrangedSubview(testModeSwitchLbl)
  }

  private func configureTestModeSwitch() {
    testModeSwitch.accessibilityLabel = "Toggle test mode"
    testModeSwitch = UISwitch()
    testModeSwitch.backgroundColor = UIColor.init(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    testModeSwitch.layer.cornerRadius = 16.0
    testModeSwitch.addTarget(self, action: #selector(toggleTestMode(testMode:)), for: .touchUpInside)
    testModeSwitchLblHStack.addArrangedSubview(testModeSwitch)
  }

  private func configureTestModeSwitchHStack() {
    testModeSwitchLblHStack.alignment = .center
    testModeSwitchLblHStack.axis = .horizontal
    testModeSwitchLblHStack.spacing = 10
    testModeSwitchLblHStack.distribution = .fillProportionally
    view.addSubview(testModeSwitchLblHStack)
    setTestModeSwitchHStackConstraints()
  }

  private func setTestModeSwitchHStackConstraints() {
    testModeSwitchLblHStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      testModeSwitchLblHStack.topAnchor.constraint(equalTo: operationBtnsVStackGrid.bottomAnchor, constant: 20),
      testModeSwitchLblHStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10)
    ])
  }

  private func scaleOperationBtn() {
    let windowWidth = UIScreen.main.bounds.size.width
    let scaleBy = 0.42
    let scaledWidth = Double(windowWidth) * scaleBy
    self.operationBtnSize = CGSize(width: scaledWidth, height: scaledWidth)
    view.setNeedsLayout()
  }

  // MARK: Action Methods
  @objc private func selectOperationBtn(_ button: UIButton) {
    cardDeckList.selectedOperation = button.tag
    cardDeckList.navigationItem.title = "\(Operation.getOperationDescription(tag: button.tag)) \(testModeEnabled ? "Test" : "Review")"
    cardDeckList.modalPresentationStyle = .fullScreen
    cardDeckList.modalTransitionStyle = .crossDissolve
    cardDeckList.testModeEnabled = testModeEnabled
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationController?.pushViewController(cardDeckList, animated: true)
  }

  @objc private func toggleTestMode(testMode: UISwitch) {
    if testMode.isOn {
      testModeEnabled = true
    } else {
      testModeEnabled = false
    }
  }
}
