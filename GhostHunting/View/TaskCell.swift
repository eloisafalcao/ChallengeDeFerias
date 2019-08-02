//
//  TaskCell.swift
//  GhostHunting
//
//  Created by Eloisa Falcão on 30/07/19.
//  Copyright © 2019 Eloisa Falcão. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var check: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
