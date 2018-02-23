//
//  PostCell.swift
//  instagram
//
//  Created by Thalia Villalobos on 2/22/18.
//  Copyright © 2018 Thalia Villalobos. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
