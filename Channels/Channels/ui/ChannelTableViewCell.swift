//
//  ChannelTableViewCell.swift
//  Channels
//
//  Created by Calvin on 15/05/2017.
//  Copyright © 2017 rmo. All rights reserved.
//

import UIKit

let ChannelTableViewCellIdentifier = "ChannelTableViewCell"

class ChannelTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(_ data: Channel) {
    titleLabel.text = data.name
  }
}
