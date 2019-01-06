//
//  SearchResultTableViewCell.swift
//  MusicApp
//
//  Created by Vu Bui on 1/6/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var infoArtist: UILabel!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
