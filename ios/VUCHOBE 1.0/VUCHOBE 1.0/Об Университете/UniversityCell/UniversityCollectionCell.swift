//
//  UniversityCollectionViewCell.swift
//  VUchobe
//
//  Created by Rovshan on 17/07/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class UniversityCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var universityBigView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
     override func awakeFromNib() {
        super.awakeFromNib()
        UniversityStyleWindows()
    }
    
    func UniversityStyleWindows(){
        universityBigView.layer.cornerRadius = 15
        universityBigView.clipsToBounds = true
    }
}

class UniversityCollectionViewCellTwo: UITableViewCell {
    
    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var tableViewLabelOne: UILabel!
    @IBOutlet weak var tableViewLabelTwo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UniversityStyleWindows()
    }
    
    func UniversityStyleWindows(){
        bigImage.layer.cornerRadius = 15
        bigImage.clipsToBounds = true
    }
}
