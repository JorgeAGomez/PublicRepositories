//
//  detailCell.swift
//  ShowPublicProjects
//
//  Created by Jorge Alejandro Gomez on 2018-03-31.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit

class detailCell: UITableViewCell {
  
  var cellText: String! {
    didSet {
      textLbl.text = "Description: \(cellText!)"
    }
  }

  let textLbl: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
    }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews(){
    
    addSubview(textLbl)
    
    textLbl.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 5, leftConstant: 15, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)
    
  }

  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
