//
//  EmployeeTableViewCell.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/25/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var empEmailLabel: UILabel!
    @IBOutlet weak var empMobileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
