//
//  ExperiencesAppsTableViewCell.swift
//  Guilherme Moresco Bisotto
//
//  Created by Guilherme Moresco Bisotto on 4/27/16.
//  Copyright © 2016 Guilherme Moresco Bisotto. All rights reserved.
//

import UIKit

class ExperiencesAppsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>> (dataSourceDelegate: D, forRow row: Int) {
        
        self.collectionView.delegate = dataSourceDelegate
        self.collectionView.dataSource = dataSourceDelegate
        self.collectionView.tag = row
        self.collectionView.reloadData()
    }

}
