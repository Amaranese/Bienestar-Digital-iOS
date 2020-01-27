//
//  UsageCell.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 26/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
class UsageCell: UITableViewCell {
    @IBOutlet weak var tvNombre: UILabel!
    @IBOutlet weak var tvType: UILabel!
    @IBOutlet weak var tvDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
