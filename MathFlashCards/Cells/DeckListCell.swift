//
//  DeckListCell.swift
//  MathFlashCards
//
//  Created by Robert Ramirez on 4/30/20.
//  Copyright © 2020 Robert Ramirez. All rights reserved.
//

import UIKit

class DeckListCell: UITableViewCell {
  static let reuseIdentifier = "deckListCell"
  var deckLabel = UILabel()
  var shuffleBtn = UIButton()
  var updateDecksToShuffle: ((Int) -> Void)?

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .clear
    configureDeckLabel()
    configureShuffleBtn()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  private func configureShuffleBtn() {
    let symbolConfig = UIImage.SymbolConfiguration(scale: .large)
    let shuffleUnselectedImage = UIImage(systemName: "shuffle", withConfiguration: symbolConfig)
    let shuffleSelectedImage = UIImage(systemName: "shuffle", withConfiguration: symbolConfig)?.withTintColor(UIColor.green, renderingMode: .alwaysOriginal)
    shuffleBtn.setImage(shuffleUnselectedImage, for: .normal)
    shuffleBtn.setImage(shuffleSelectedImage, for: .selected)
    //shuffleBtn.backgroundColor = .black
    shuffleBtn.setContentHuggingPriority(UILayoutPriority.init(252), for: .horizontal)
    shuffleBtn.tintColor = .white
    shuffleBtn.addTarget(self, action: #selector(updateDecksToShuffle(sender:)), for: .touchUpInside)
    contentView.addSubview(shuffleBtn)
    setShuffleBtnConstraints()
  }

  private func setShuffleBtnConstraints() {
    shuffleBtn.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      shuffleBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      shuffleBtn.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -10),
      shuffleBtn.leadingAnchor.constraint(equalTo: deckLabel.trailingAnchor, constant: 10),
      shuffleBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }

  private func configureDeckLabel() {
    //deckLabel.backgroundColor = .blue
    deckLabel.textColor = .white
    deckLabel.font = deckFont?.withSize(25)
    deckLabel.text = ""
    contentView.addSubview(deckLabel)
    setDeckLabelContraints()
  }

  private func setDeckLabelContraints() {
    deckLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      deckLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      deckLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      deckLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])
  }

  // MARK: Action Methods
  @objc private func updateDecksToShuffle(sender: UIButton) {
    if let updateDecksToShuffle = updateDecksToShuffle {
      updateDecksToShuffle(sender.tag)
      if sender.isSelected {
        sender.isSelected = false
      } else {
        sender.isSelected = true
      }
    }
  }
}
// MARK: Extensions
extension UITableViewCell {
  var reorderControlImageView: UIImageView? {
    let reorderControl = self.subviews.first { view -> Bool in
      view.classForCoder.description() == "UITableViewCellReorderControl"
    }
    return reorderControl?.subviews.first { view -> Bool in
      view is UIImageView
    } as? UIImageView
  }

  var checkBoxControlImageView: UIImageView? {
    let checkBoxControl = self.subviews.first { view -> Bool in
      view.classForCoder.description() == "UITableViewCellEditControl"
    }
    return checkBoxControl?.subviews.first { view -> Bool in
      view is UIImageView
    } as? UIImageView
  }
}

extension UIImageView {
  func tint(color: UIColor) {
    self.image = self.image?.withRenderingMode(.alwaysTemplate)
    self.tintColor = color
  }
}
