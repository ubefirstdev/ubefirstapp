//
//  PersonasTableViewCell.swift
//  Ubefirstapp
//
//  Created by Luis Oliva on 02/01/19.
//  Copyright © 2019 UMayab. All rights reserved.
//

import UIKit

class PersonasTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_nombreHijo: UILabel!
    @IBOutlet weak var lbl_parentesco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
