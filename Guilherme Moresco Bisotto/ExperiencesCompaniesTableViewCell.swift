//
//  ExperiencesCompaniesTableViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/27/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class ExperiencesCompaniesTableViewCell: UITableViewCell {

    @IBOutlet var labelTimeInCompany: UILabel!
    @IBOutlet var labelFunctionInCompany: UILabel!
    @IBOutlet var labelCompanyName: UILabel!
    @IBOutlet var textviewDesc: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
