//
//  GaleryTableViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/23/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class GaleryTableViewCell: UITableViewCell {
    
    var imgName: String!
    
    @IBOutlet var imageGalery: UIImageView!
    @IBOutlet var viewImgWrapper: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewImgWrapper.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func didScroll(tableview: UITableView) {
        
        let offsetY = tableview.contentOffset.y
            let x = self.imageGalery.frame.origin.x
            let w = self.imageGalery.bounds.width
            let h = self.imageGalery.bounds.height
            let y = ((offsetY - self.frame.origin.y) / h) * 25
            self.imageGalery.frame = CGRectMake(x, y, w, h)
    }
}
