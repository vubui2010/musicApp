//
//  OneSingTableViewCell.swift
//  MusicApp
//
//  Created by Vu Bui on 12/12/18.
//  Copyright © 2018 Vu Bui. All rights reserved.
//

import UIKit

class OneSingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSong: UIImageView!
    
    @IBOutlet weak var nameSinger: UILabel!
    @IBOutlet weak var nameSong: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
