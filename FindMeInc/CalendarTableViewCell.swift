//
//  CalendarTableViewCell.swift
//  FindMeInc
//
//  Created by Alex Vecher on 24.02.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tattooDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
