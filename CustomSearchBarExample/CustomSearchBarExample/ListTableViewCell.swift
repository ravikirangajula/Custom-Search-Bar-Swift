//
//  ListTableViewCell.swift
//  CustomSearchBarExample
//
//  Created by Ravikiran on 02/09/2019.
//  Copyright © 2019 Ravikiran. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    public static let kCell = "ListTableViewCell"
    
    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
