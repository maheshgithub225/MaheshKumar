//
//  SearchRecipeTableViewCell.swift
//  Chefulate
//
//  Created by Johnathan Taylor Sutton on 11/19/16.
//  Copyright © 2016 Johnathan Taylor Sutton. All rights reserved.
//

import UIKit

class SearchRecipeTableViewCell: UITableViewCell {
    @IBOutlet var R_name: UILabel!
    @IBOutlet var C_Name: UILabel!
    @IBOutlet var S_Size: UILabel!
    @IBOutlet var Date: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
