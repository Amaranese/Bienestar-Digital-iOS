//
//  AppCell.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

class AppCell: UITableViewCell {

    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var tvNombre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
