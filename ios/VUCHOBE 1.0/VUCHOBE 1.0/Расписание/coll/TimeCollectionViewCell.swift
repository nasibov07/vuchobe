//
//  TimeCollectionViewCell.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 02/11/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class TimeTableTimeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var myViewConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var myViewConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.black.cgColor
    }
}

class TimeTableLessonCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var myViewConstraintWidth: NSLayoutConstraint!
    @IBOutlet weak var myViewConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//
    }
}


