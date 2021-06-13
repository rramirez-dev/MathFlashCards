//
//  CategoryViewController.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 11/16/18.
//  Copyright © 2018 Robert Ramirez. All rights reserved.
//

import UIKit

class CardDeckListViewController: UIViewController {
  var selectedOperation: Int?
  var testModeEnabled = false
  private var cardSets = [Int: [Card]]()
  private var cards = [Card]()
  private var startBtn = UIButton()
  private var deckList = UITableView()
  private var deckListCell = UITableViewCell()
  private var testModeSwitch = UISwitch()
  private var decks = [Operation: [Int: [Card]]]()
  private var factorRange = Array(0...12)
  private var decksToShuffle = [Int]()
  let btnCornerRadius: CGFloat = 10.0
  let btnBorderWidth: CGFloat = 2.0
  let borderColor = UIColor.white

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.darkModeBackgroundColor
    configureStartBtn()
    configureCardDeckList()
    decks = CardGenerator.generateCardDeck()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    deckList.reloadData()
  }

  // MARK: Configure Card Deck List
  private func configureCardDeckList() {
    deckList.backgroundView = nil
    deckList.backgroundColor = .clear
    deckList.separatorColor = .white
    deckList.delegate = self
    deckList.dataSource = self
    deckList.register(DeckListCell.self, forCellReuseIdentifier: DeckListCell.reuseIdentifier)
    deckList.setEditing(true, animated: false)
    deckList.allowsMultipleSelectionDuringEditing = true
    view.addSubview(deckList)
    setCardDeckListContraints()
  }

  private func setCardDeckListContraints() {
    deckList.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      deckList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      deckList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      deckList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      deckList.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -20)
    ])
  }

  // MARK: Configure Start Button
  private func configureStartBtn() {
    startBtn.titleLabel?.font = deckFont
    startBtn.layer.cornerRadius = 15
    startBtn.layer.borderWidth = btnBorderWidth
    startBtn.layer.borderColor = borderColor.cgColor
    startBtn.clipsToBounds = true
    startBtn.setTitle("Start", for: .normal)
    view.addSubview(startBtn)
    setStartBtnContraints()
    startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
  }

  private func setStartBtnContraints() {
    startBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      startBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      startBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      startBtn.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  // MARK: Action Methods
  @objc func start() {
    let flowlayout = UICollectionViewFlowLayout()
    flowlayout.scrollDirection = .horizontal
    flowlayout.minimumLineSpacing = 0
    let cardVC = CardCollectionViewController(collectionViewLayout: flowlayout)

    // swiftlint:disable force_unwrapping
    switch  selectedOperation {
    case 1:
      cardSets = decks[Operation.addition]!
    case 2:
      cardSets = decks[Operation.multiplication]!
    case 3:
      cardSets = decks[Operation.division]!
    case 4:
      cardSets = decks[Operation.subtraction]!
    default:
      fatalError("Could not generate cards from the seleced deck")
    }

    if let selectedRows = deckList.indexPathsForSelectedRows {
      cards = []
      for indexPath in selectedRows.sorted() {
        let factor = factorRange[indexPath.row]
        var cardSet = [Card]()

        // Shuffle decks
        if decksToShuffle.contains(factor) {
          cardSet = cardSets[factor]!.shuffled()
          cards.append(contentsOf: cardSet)
        } else {
          cardSet = cardSets[factor]!
          cards.append(contentsOf: cardSet)
        }
      }

      cardVC.cards = testModeEnabled ? self.cards.shuffled() : self.cards
      cardVC.testModeEnabled = testModeEnabled
      cardVC.modalPresentationStyle = .fullScreen
      cardVC.modalTransitionStyle = .crossDissolve
      navigationItem.setHidesBackButton(false, animated: false)
      navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      navigationController?.pushViewController(cardVC, animated: true)
    } else {
      let alert = AlertViewController()
      alert.alertTitle = "Warning"
      alert.alertMessage = "You must select a card set"
      alert.modalPresentationStyle = .overCurrentContext
      alert.modalTransitionStyle = .crossDissolve
      present(alert, animated: true, completion: nil)
    }
  }
}

// MARK: Table View Data Source Extension
extension CardDeckListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DeckListCell.reuseIdentifier, for: indexPath) as? DeckListCell else { return UITableViewCell() }

    let cardSetNumber = factorRange[indexPath.row]
    cell.deckLabel.text = "\(cardSetNumber)'s Card Set"
    let cellBackgroundView = UIView(frame: CGRect.zero)
    cellBackgroundView.backgroundColor = .clear
    cell.multipleSelectionBackgroundView = cellBackgroundView
    cell.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
    cell.shuffleBtn.tag = cardSetNumber
    cell.shuffleBtn.isEnabled = false
    cell.tintColor = UIColor.deckListTint

    // Add and Remove decks to be shuffled from decks to shuffle
    cell.updateDecksToShuffle = { row in
      if self.decksToShuffle.contains(row) {
        let itemIndex = self.decksToShuffle.firstIndex(of: row)
        self.decksToShuffle.remove(at: itemIndex!)
      } else {
        self.decksToShuffle.append(row)
      }
    }
    cell.shuffleBtn.isHidden = testModeEnabled

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? DeckListCell {
      cell.shuffleBtn.isEnabled = true
    }
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) as? DeckListCell {
      cell.shuffleBtn.isSelected = false
      cell.shuffleBtn.isEnabled = false
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return factorRange.count
  }

  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
  }
}

extension CardDeckListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .none
  }
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    if testModeEnabled {
      return false
    } else {
      return true
    }
  }

  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    return false
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let itemToMove = factorRange[sourceIndexPath.row]
    factorRange.remove(at: sourceIndexPath.row)
    factorRange.insert(itemToMove, at: destinationIndexPath.row)
  }
}
