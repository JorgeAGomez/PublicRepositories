//
//  RepoCellTableViewCell.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-28.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }
  
  open var repoTitleText: String! {
    didSet {
      titleLabel.text = repoTitleText
      //style label
      titleLabel.textColor = .black
    }
  }
  
  //create labels
  let titleLabel: UILabel = {
    let label = UILabel()
    //label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    return label
  }()
  
  
  func setupViews(){
      self.accessoryType = .disclosureIndicator
    addSubview(titleLabel)
  
    titleLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
  }
  
}
