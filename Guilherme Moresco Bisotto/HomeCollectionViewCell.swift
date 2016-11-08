//
//  HomeCollectionViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/19/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelHomeCell.textColor = UIColor.whiteColor()
        self.imageHomeCell.layer.cornerRadius = 0
        self.imageHomeCell.layer.masksToBounds = false

    }
    
    @IBOutlet weak var imageHomeCell: UIImageView!
    @IBOutlet weak var labelHomeCell: UILabel!
}
